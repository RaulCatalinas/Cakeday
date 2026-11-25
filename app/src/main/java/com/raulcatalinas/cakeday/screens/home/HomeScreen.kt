package com.raulcatalinas.cakeday.screens.home

import android.content.Intent
import android.net.Uri
import android.provider.Settings
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.PaddingValues
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.items
import androidx.compose.foundation.lazy.rememberLazyListState
import androidx.compose.material3.CircularProgressIndicator
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.platform.LocalResources
import androidx.compose.ui.res.stringResource
import androidx.compose.ui.unit.dp
import androidx.hilt.lifecycle.viewmodel.compose.hiltViewModel
import androidx.lifecycle.Lifecycle
import androidx.lifecycle.compose.LifecycleEventEffect
import androidx.lifecycle.compose.collectAsStateWithLifecycle
import com.raulcatalinas.cakeday.R
import com.raulcatalinas.cakeday.core.birthdays.types.UiResult
import com.raulcatalinas.cakeday.core.birthdays.types.UiState
import com.raulcatalinas.cakeday.core.birthdays.viewmodels.BirthdayViewModel
import com.raulcatalinas.cakeday.screens.home.components.BirthdayItem
import com.raulcatalinas.cakeday.shared.components.AppFloatingActionButton
import com.raulcatalinas.cakeday.shared.components.AppScaffold
import com.raulcatalinas.cakeday.shared.components.CenteredMessage
import com.raulcatalinas.cakeday.shared.components.ErrorMessage
import com.raulcatalinas.cakeday.shared.components.Subtitle
import com.raulcatalinas.cakeday.shared.extensions.verticalScrollbar
import com.raulcatalinas.cakeday.shared.utils.LocalSnackbarController
import kotlinx.datetime.LocalTime

@Composable
fun HomeScreen(
    viewModel: BirthdayViewModel = hiltViewModel(),
    onEditBirthday: (Int) -> Unit,
    onCreateBirthday: () -> Unit
) {
    val snackbar = LocalSnackbarController.current
    val resources = LocalResources.current
    val context = LocalContext.current

    val listState = rememberLazyListState()

    val upcomingBirthdaysState by viewModel.upcomingBirthdays.collectAsStateWithLifecycle()

    LifecycleEventEffect(
        event = Lifecycle.Event.ON_RESUME,
        onEvent = viewModel::refreshUpcomingBirthdays
    )

    AppScaffold(
        floatingActionButton = {
            AppFloatingActionButton(
                contentDescription = resources.getString(R.string.add_birthday),
                onClick = onCreateBirthday
            )
        }
    ) { paddingValues ->
        Box(
            modifier = Modifier
                .padding(paddingValues)
                .padding(horizontal = 20.dp, vertical = 16.dp)
                .fillMaxSize()
        ) {
            when (val state = upcomingBirthdaysState) {
                UiState.Loading -> CircularProgressIndicator(
                    modifier =
                        Modifier
                            .align(Alignment.Center)
                            .size(48.dp),
                    strokeWidth = 2.dp
                )

                is UiState.Error -> ErrorMessage(
                    text = stringResource(state.messageRes),
                    onRetry = viewModel::refreshUpcomingBirthdays
                )

                is UiState.Success -> {
                    if (state.data.isEmpty()) {
                        CenteredMessage(
                            stringResource(
                                R.string.no_birthdays_yet
                            )
                        )

                        return@Box
                    }

                    LazyColumn(
                        modifier =
                            Modifier
                                .verticalScrollbar(listState)
                                .fillMaxSize(),
                        verticalArrangement = Arrangement.spacedBy(16.dp),
                        horizontalAlignment = Alignment.CenterHorizontally,
                        state = listState,
                        contentPadding = PaddingValues(bottom = 88.dp)
                    ) {
                        item(key = "next_birthday") {
                            val closestBirthday = state.data.first()

                            Subtitle(
                                stringResource(
                                    R.string.next_birthday
                                )
                            )

                            BirthdayItem(
                                birthday = closestBirthday,
                                gradientEnabled = true,
                                onEditBirthday = onEditBirthday,
                                onDeleteBirthday = { id ->
                                    viewModel.deleteBirthday(id) { result ->
                                        when (result) {
                                            is UiResult.Error -> {
                                                snackbar.show(
                                                    resources.getString(
                                                        result.messageRes
                                                    )
                                                )
                                            }

                                            is UiResult.Success -> {
                                                viewModel.refreshUpcomingBirthdays()

                                                snackbar.show(
                                                    resources.getString(
                                                        R.string.deleted_birthday
                                                    )
                                                )
                                            }
                                        }
                                    }
                                },
                                onRetrySchedule = { birthday ->
                                    viewModel.scheduleReminder(
                                        id = birthday.id,
                                        birthday = birthday.birthday,
                                        notificationTime = LocalTime(
                                            birthday.notificationHour,
                                            birthday.notificationMinute,
                                            0
                                        )
                                    ) { result ->
                                        when (result) {
                                            is UiResult.Error -> {
                                                snackbar.show(
                                                    message = resources.getString(
                                                        result.messageRes
                                                    ),
                                                    actionLabel = resources.getString(
                                                        R.string.open_settings
                                                    ),
                                                    onAction = {
                                                        val intent = Intent(
                                                            Settings.ACTION_REQUEST_SCHEDULE_EXACT_ALARM,
                                                            Uri
                                                                .Builder()
                                                                .scheme("package")
                                                                .authority(context.packageName)
                                                                .build()
                                                        )

                                                        context.startActivity(intent)
                                                    }
                                                )
                                            }

                                            is UiResult.Success -> {
                                                snackbar.show(
                                                    resources.getString(
                                                        R.string.reminder_scheduled
                                                    )
                                                )
                                            }
                                        }
                                    }
                                }
                            )
                        }

                        item(key = "upcoming_birthdays") {
                            Spacer(modifier = Modifier.height(16.dp))

                            Subtitle(
                                stringResource(
                                    R.string.upcoming_birthdays
                                )
                            )
                        }

                        items(
                            items = state.data.drop(1),
                            key = { birthday -> birthday.id }
                        ) { birthday ->
                            BirthdayItem(
                                birthday = birthday,
                                onEditBirthday = onEditBirthday,
                                onDeleteBirthday = { id ->
                                    viewModel.deleteBirthday(id) { result ->
                                        when (result) {
                                            is UiResult.Error -> {
                                                snackbar.show(
                                                    resources.getString(
                                                        result.messageRes
                                                    )
                                                )
                                            }

                                            is UiResult.Success -> {
                                                viewModel.refreshUpcomingBirthdays()

                                                snackbar.show(
                                                    resources.getString(
                                                        R.string.deleted_birthday
                                                    )
                                                )
                                            }
                                        }
                                    }
                                },
                                onRetrySchedule = { item ->
                                    viewModel.scheduleReminder(
                                        id = item.id,
                                        birthday = item.birthday,
                                        notificationTime = LocalTime(
                                            item.notificationHour,
                                            item.notificationMinute,
                                            0
                                        )
                                    ) { result ->
                                        when (result) {
                                            is UiResult.Error -> {
                                                snackbar.show(
                                                    message = resources.getString(result.messageRes),
                                                    actionLabel = resources.getString(R.string.open_settings),
                                                    onAction = {
                                                        val intent = Intent(
                                                            Settings.ACTION_REQUEST_SCHEDULE_EXACT_ALARM,
                                                            Uri.Builder()
                                                                .scheme("package")
                                                                .authority(context.packageName)
                                                                .build()
                                                        )

                                                        context.startActivity(intent)
                                                    }
                                                )
                                            }

                                            is UiResult.Success -> {
                                                snackbar.show(
                                                    resources.getString(R.string.reminder_scheduled)
                                                )
                                            }
                                        }
                                    }
                                }
                            )
                        }
                    }
                }
            }
        }
    }
}
