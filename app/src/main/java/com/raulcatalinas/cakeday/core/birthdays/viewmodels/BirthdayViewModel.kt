package com.raulcatalinas.cakeday.core.birthdays.viewmodels

import android.util.Log
import androidx.annotation.StringRes
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.raulcatalinas.cakeday.R
import com.raulcatalinas.cakeday.core.birthdays.constants.BIRTHDAY_VIEW_MODEL_TAG
import com.raulcatalinas.cakeday.core.birthdays.repositories.BirthdayRepository
import com.raulcatalinas.cakeday.core.birthdays.types.UiResult
import com.raulcatalinas.cakeday.core.birthdays.types.UiState
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
import kotlinx.coroutines.flow.flatMapLatest
import kotlinx.coroutines.flow.flow
import kotlinx.coroutines.flow.stateIn
import kotlinx.coroutines.flow.update
import kotlinx.coroutines.launch
import kotlinx.datetime.LocalTime
import java.time.LocalDate
import javax.inject.Inject

@HiltViewModel
class BirthdayViewModel @Inject constructor(
    private val repository: BirthdayRepository
) : ViewModel() {
    private val refreshTrigger = MutableStateFlow(0)

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
        onResult: (UiResult<Long>) -> Unit
    ) {
        viewModelScope.launch {
            _isSaving.value = true

            try {
                onResult(
                    attempt(R.string.birthday_not_saved) {
                        repository.createBirthday(
                            birthday = birthday,
                            contactInfo = contactInfo,
                            notificationTime = notificationTime,
                            personalisedMessage = personalisedMessage,
                            note = note
                        )
                    }
                )
            } finally {
                _isSaving.value = false
            }
        }
    }

    fun refresh() {
        refreshTrigger.update { it + 1 }
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