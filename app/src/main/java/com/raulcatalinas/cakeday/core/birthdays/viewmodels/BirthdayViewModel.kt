package com.raulcatalinas.cakeday.core.birthdays.viewmodels

import android.util.Log
import androidx.annotation.StringRes
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.raulcatalinas.cakeday.R
import com.raulcatalinas.cakeday.backend.mappers.toDomain
import com.raulcatalinas.cakeday.core.birthdays.constants.BIRTHDAY_VIEW_MODEL_TAG
import com.raulcatalinas.cakeday.core.birthdays.constants.UPCOMING_BIRTHDAYS_LIMIT
import com.raulcatalinas.cakeday.core.birthdays.models.SaveBirthdayData
import com.raulcatalinas.cakeday.core.birthdays.repositories.BirthdayRepository
import com.raulcatalinas.cakeday.core.birthdays.types.UiResult
import com.raulcatalinas.cakeday.core.birthdays.types.UiState
import com.raulcatalinas.cakeday.core.reminders.repositories.ReminderRepository
import com.raulcatalinas.cakeday.screens.settings.repositories.SettingsRepository
import com.raulcatalinas.cakeday.services.AppAlarmManager
import com.raulcatalinas.cakeday.shared.models.BirthdayModel
import com.raulcatalinas.cakeday.shared.types.ContactInfo
import dagger.hilt.android.lifecycle.HiltViewModel
import kotlinx.coroutines.CancellationException
import kotlinx.coroutines.ExperimentalCoroutinesApi
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.SharingStarted
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.flow.asStateFlow
import kotlinx.coroutines.flow.catch
import kotlinx.coroutines.flow.first
import kotlinx.coroutines.flow.flatMapLatest
import kotlinx.coroutines.flow.flow
import kotlinx.coroutines.flow.stateIn
import kotlinx.coroutines.flow.update
import kotlinx.coroutines.launch
import kotlinx.datetime.LocalTime
import kotlinx.datetime.toJavaLocalTime
import java.time.LocalDate
import javax.inject.Inject

@HiltViewModel
class BirthdayViewModel @Inject constructor(
    private val repository: BirthdayRepository,
    private val reminderRepository: ReminderRepository,
    private val appAlarmManager: AppAlarmManager,
    private val settingsRepoistory: SettingsRepository
) : ViewModel() {
    private val refreshTrigger = MutableStateFlow(0)
    private val refreshUpcomingTrigger = MutableStateFlow(0)

    @OptIn(ExperimentalCoroutinesApi::class)
    val birthdays: StateFlow<UiState<List<BirthdayModel>>> =
        refreshTrigger
            .flatMapLatest {
                flow {
                    if (birthdays.value is UiState.Error) emit(UiState.Loading)

                    val birthdays = repository.getAllBirthdays()

                    emit(
                        UiState.Success(birthdays)
                    )
                }.catch { e ->
                    if (e is CancellationException) throw e

                    Log.e(
                        BIRTHDAY_VIEW_MODEL_TAG,
                        "Error loading birthdays: ${e.message}",
                        e
                    )

                    emit(
                        UiState.Error(
                            R.string.error_loading_birthdays
                        )
                    )
                }
            }
            .stateIn(
                scope = viewModelScope,
                started = SharingStarted.WhileSubscribed(0),
                initialValue = UiState.Loading
            )

    @OptIn(ExperimentalCoroutinesApi::class)
    val upcomingBirthdays: StateFlow<UiState<List<BirthdayModel>>> =
        refreshUpcomingTrigger
            .flatMapLatest {
                flow {
                    if (upcomingBirthdays.value is UiState.Error) {
                        emit(UiState.Loading)
                    }

                    val today = LocalDate.now()

                    val result = attempt(R.string.upcoming_birthdays_load_error) {
                        repository.getUpcomingBirthdays(
                            currentMonth = today.monthValue,
                            currentDay = today.dayOfMonth,
                            limit = UPCOMING_BIRTHDAYS_LIMIT
                        )
                    }

                    when (result) {
                        is UiResult.Error -> {
                            emit(
                                UiState.Error(
                                    result.messageRes
                                )
                            )
                        }

                        is UiResult.Success -> {
                            emit(
                                UiState.Success(
                                    result.data.map { it.toDomain() }
                                )
                            )
                        }
                    }
                }.catch { e ->
                    if (e is CancellationException) throw e

                    Log.e(
                        BIRTHDAY_VIEW_MODEL_TAG,
                        "Error loading upcoming birthdays: ${e.message}",
                        e
                    )

                    emit(
                        UiState.Error(
                            R.string.upcoming_birthdays_load_error
                        )
                    )
                }
            }
            .stateIn(
                scope = viewModelScope,
                started = SharingStarted.WhileSubscribed(0),
                initialValue = UiState.Loading
            )

    private val _isSaving = MutableStateFlow(false)
    val isSaving: StateFlow<Boolean> = _isSaving.asStateFlow()

    // For one-off actions: one callback with one result.
    fun getBirthdayById(
        id: Int,
        onResult: (UiResult<BirthdayModel>) -> Unit
    ) {
        viewModelScope.launch {
            val result = attempt(R.string.error_loading_birthday) {
                repository.getBirthdayById(id)
            }

            onResult(
                when (result) {
                    is UiResult.Success ->
                        result.data?.let { UiResult.Success(it) }
                            ?: UiResult.Error(R.string.birthday_not_found)

                    is UiResult.Error -> result
                }
            )
        }
    }

    fun deleteBirthday(id: Int, onResult: (UiResult<Int>) -> Unit) {
        viewModelScope.launch {
            val result = attempt(R.string.error_deleting_birthday) {
                repository.deleteBirthday(id)
            }

            reminderRepository.deleteReminder(id)
            appAlarmManager.cancelAlarms(id)

            if (result is UiResult.Success) refresh()

            onResult(result)
        }
    }

    fun saveBirthday(
        birthday: LocalDate,
        contactInfo: ContactInfo,
        personalisedMessage: String?,
        notificationTime: LocalTime,
        note: String?,
        advanceNotice: Boolean,
        onResult: (UiResult<SaveBirthdayData>) -> Unit
    ) {
        viewModelScope.launch {
            _isSaving.value = true

            try {
                val existsBirthday = repository.existsBirthday(
                    name = contactInfo.name,
                    phone = contactInfo.phone,
                    day = birthday.dayOfMonth,
                    month = birthday.monthValue
                )

                if (existsBirthday) {
                    onResult(
                        UiResult.Error(
                            R.string.birthday_already_exists
                        )
                    )

                    return@launch
                }

                val saveResult = attempt(R.string.birthday_not_saved) {
                    repository.createBirthday(
                        birthday = birthday,
                        contactInfo = contactInfo,
                        notificationTime = notificationTime,
                        personalisedMessage = personalisedMessage,
                        note = note
                    )
                }

                val finalResult = when (saveResult) {
                    is UiResult.Success -> {
                        val birthdayId = saveResult.data

                        val reminderResult = attempt(
                            R.string.birthday_saved_without_reminder
                        ) {
                            reminderRepository.scheduleReminder(
                                id = birthdayId.toInt(),
                                date = birthday,
                                time = notificationTime.toJavaLocalTime(),
                                advanceNotice = advanceNotice
                            )
                        }

                        when (reminderResult) {
                            is UiResult.Error -> UiResult.Error(reminderResult.messageRes)
                            is UiResult.Success -> UiResult.Success(
                                SaveBirthdayData(
                                    birthdayId = birthdayId,
                                    reminderScheduled = reminderResult.data
                                )
                            )
                        }
                    }

                    is UiResult.Error -> saveResult
                }

                onResult(finalResult)
            } finally {
                _isSaving.value = false
            }
        }
    }

    fun updateBirthday(
        id: Int,
        birthday: LocalDate,
        personalisedMessage: String?,
        notificationTime: LocalTime,
        note: String?,
        onResult: (UiResult<SaveBirthdayData>) -> Unit
    ) {
        viewModelScope.launch {
            _isSaving.value = true

            try {
                val updateResult = attempt(R.string.birthday_not_saved) {
                    repository.updateBirthday(
                        id = id,
                        day = birthday.dayOfMonth,
                        month = birthday.monthValue,
                        year = birthday.year,
                        personalisedMessage = personalisedMessage,
                        note = note
                    )
                }

                val finalResult = when (updateResult) {
                    is UiResult.Success -> {
                        val reminderResult = attempt(
                            R.string.birthday_saved_without_reminder
                        ) {
                            reminderRepository.scheduleReminder(
                                id = id,
                                date = birthday,
                                time = notificationTime.toJavaLocalTime(),
                                advanceNotice =
                                    settingsRepoistory
                                        .getSettings()
                                        .first()
                                        .advanceNotice
                            )
                        }

                        UiResult.Success(
                            SaveBirthdayData(
                                birthdayId = id.toLong(),
                                reminderScheduled =
                                    reminderResult is UiResult.Success
                                            && reminderResult.data
                            )
                        )
                    }

                    is UiResult.Error -> updateResult
                }

                onResult(finalResult)
            } finally {
                _isSaving.value = false
            }
        }
    }

    fun scheduleReminder(
        id: Int,
        birthday: LocalDate,
        notificationTime: LocalTime,
        onResult: (UiResult<Unit>) -> Unit
    ) {
        viewModelScope.launch {
            val result = attempt(R.string.reminder_schedule_error) {
                reminderRepository.scheduleReminder(
                    id = id,
                    date = birthday,
                    time = notificationTime.toJavaLocalTime(),
                    advanceNotice = settingsRepoistory.getSettings().first().advanceNotice
                )
            }

            onResult(
                when (result) {
                    is UiResult.Success ->
                        if (result.data) UiResult.Success(Unit)
                        else UiResult.Error(R.string.reminder_permission_missing)

                    is UiResult.Error -> result
                }
            )

            if (result is UiResult.Success && result.data) refresh()
        }
    }

    fun refresh() {
        refreshTrigger.update { it + 1 }
    }

    fun refreshUpcomingBirthdays() {
        refreshUpcomingTrigger.update { it + 1 }
    }

    private suspend fun <T> attempt(
        @StringRes errorRes: Int,
        block: suspend () -> T
    ): UiResult<T> {
        return try {
            UiResult.Success(block())
        } catch (e: CancellationException) {
            throw e
        } catch (e: Exception) {
            Log.e(
                BIRTHDAY_VIEW_MODEL_TAG,
                "Error in BirthdayViewModel: ${e.message}",
                e
            )

            UiResult.Error(errorRes)
        }
    }
}