package com.raulcatalinas.cakeday.screens.allbirthdays

import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.PaddingValues
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.imePadding
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.items
import androidx.compose.foundation.lazy.rememberLazyListState
import androidx.compose.material3.Button
import androidx.compose.material3.CircularProgressIndicator
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.saveable.rememberSaveable
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.hapticfeedback.HapticFeedback
import androidx.compose.ui.hapticfeedback.HapticFeedbackType
import androidx.compose.ui.platform.LocalConfiguration
import androidx.compose.ui.platform.LocalHapticFeedback
import androidx.compose.ui.platform.LocalResources
import androidx.compose.ui.res.stringResource
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.text.style.TextOverflow
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import androidx.hilt.lifecycle.viewmodel.compose.hiltViewModel
import androidx.lifecycle.compose.collectAsStateWithLifecycle
import com.raulcatalinas.cakeday.R
import com.raulcatalinas.cakeday.core.birthdays.types.UiResult
import com.raulcatalinas.cakeday.core.birthdays.types.UiState
import com.raulcatalinas.cakeday.core.birthdays.viewmodels.BirthdayViewModel
import com.raulcatalinas.cakeday.screens.allbirthdays.types.BirthdayEntry
import com.raulcatalinas.cakeday.screens.allbirthdays.types.BirthdayItem
import com.raulcatalinas.cakeday.screens.allbirthdays.types.HeaderItem
import com.raulcatalinas.cakeday.shared.components.AppFloatingActionButton
import com.raulcatalinas.cakeday.shared.components.AppScaffold
import com.raulcatalinas.cakeday.shared.components.AppSearchBar
import com.raulcatalinas.cakeday.shared.components.CircleAvatar
import com.raulcatalinas.cakeday.shared.components.ConfirmDialog
import com.raulcatalinas.cakeday.shared.components.ContactCard
import com.raulcatalinas.cakeday.shared.components.EditDeleteMenu
import com.raulcatalinas.cakeday.shared.components.StatusPill
import com.raulcatalinas.cakeday.shared.extensions.normalized
import com.raulcatalinas.cakeday.shared.extensions.normalizedInitial
import com.raulcatalinas.cakeday.shared.extensions.safeForDisplay
import com.raulcatalinas.cakeday.shared.extensions.verticalScrollbar
import com.raulcatalinas.cakeday.shared.models.BirthdayModel
import com.raulcatalinas.cakeday.shared.utils.BirthdayDateFormatter
import com.raulcatalinas.cakeday.shared.utils.LocalSnackbarController
import com.raulcatalinas.cakeday.shared.utils.timeUntilBirthday
import java.text.Collator
import java.time.LocalDate

@Composable
fun AllBirthdaysScreen(
    viewModel: BirthdayViewModel = hiltViewModel(),
    onEditBirthday: (Int) -> Unit,
    onCreateBirthday: () -> Unit
) {
    val snackbar = LocalSnackbarController.current
    val resources = LocalResources.current
    val hapticFeedback = LocalHapticFeedback.current

    val birthdaysState by viewModel.birthdays.collectAsStateWithLifecycle()

    AppScaffold(
        floatingActionButton = {
            AppFloatingActionButton(
                contentDescription = stringResource(R.string.add_birthday)
            ) {
                onCreateBirthday()
            }
        }
    ) { paddingValues ->
        Box(
            modifier = Modifier
                .padding(paddingValues)
                .imePadding()
                .padding(horizontal = 20.dp, vertical = 16.dp)
                .fillMaxSize()
        ) {
            when (val state = birthdaysState) {
                UiState.Loading -> CircularProgressIndicator(
                    modifier =
                        Modifier
                            .align(Alignment.Center)
                            .size(48.dp),
                    strokeWidth = 2.dp
                )

                is UiState.Error -> ErrorMessage(
                    text = stringResource(state.messageRes),
                    onRetry = viewModel::refresh
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

                    BirthdaysList(
                        birthdays = state.data,
                        hapticFeedback = hapticFeedback,
                        onEditBirthday = { id ->
                            viewModel.getBirthdayById(id) {
                                when (it) {
                                    is UiResult.Error -> snackbar.show(
                                        resources.getString(
                                            it.messageRes
                                        )
                                    )

                                    is UiResult.Success -> onEditBirthday(it.data.id)
                                }
                            }
                        },
                        onDeleteBirthday = { id ->
                            viewModel.deleteBirthday(id) {
                                when (it) {
                                    is UiResult.Error -> snackbar.show(
                                        resources.getString(
                                            it.messageRes
                                        )
                                    )

                                    is UiResult.Success -> snackbar.show(
                                        resources.getString(
                                            R.string.deleted_birthday
                                        )
                                    )
                                }
                            }
                        }
                    )
                }
            }
        }
    }
}

@Composable
private fun BirthdaysList(
    birthdays: List<BirthdayModel>,
    hapticFeedback: HapticFeedback,
    onEditBirthday: (Int) -> Unit,
    onDeleteBirthday: (Int) -> Unit
) {
    val listState = rememberLazyListState()
    val locale = LocalConfiguration.current.locales[0]

    val formatter = BirthdayDateFormatter(locale)

    val currentYear = LocalDate.now().year

    var query by rememberSaveable { mutableStateOf("") }

    val entries = remember(birthdays, locale) {
        val collator =
            Collator
                .getInstance(locale)
                .apply { strength = Collator.PRIMARY }

        val dateFormatter = BirthdayDateFormatter(locale)

        birthdays
            .map { it to collator.getCollationKey(it.contactInfo.name.normalized) }
            .sortedBy { it.second }
            .map { (data, _) ->
                val name = data.contactInfo.name
                val includeYear = data.birthday.year > 0

                val dateText = dateFormatter.format(data.birthday, includeYear)
                val numericDate = dateFormatter.formatNumeric(
                    data.birthday,
                    includeYear
                )

                BirthdayEntry(
                    data = data,
                    initial = name.normalizedInitial,
                    dateText = dateText,
                    searchText = "$name $dateText $numericDate".normalized
                )
            }
    }

    val listItems = remember(entries, query) {
        val tokens =
            query
                .normalized
                .split(' ')
                .filter { it.isNotEmpty() }

        buildList {
            entries
                .filter { entry ->
                    tokens.all { entry.searchText.contains(it) }
                }
                .groupBy { it.initial }
                .forEach { (letter, group) ->
                    add(HeaderItem(letter))

                    group.forEach {
                        add(BirthdayItem(it.data, it.dateText))
                    }
                }
        }
    }

    Column(
        modifier = Modifier.fillMaxSize(),
        horizontalAlignment = Alignment.CenterHorizontally,
        verticalArrangement = Arrangement.spacedBy(16.dp)
    ) {
        AppSearchBar {
            query = it
        }

        LazyColumn(
            modifier =
                Modifier
                    .verticalScrollbar(listState)
                    .fillMaxWidth(),
            verticalArrangement = Arrangement.spacedBy(16.dp),
            state = listState,
            contentPadding = PaddingValues(bottom = 88.dp)
        ) {
            if (listItems.isEmpty()) {
                item {
                    Text(
                        modifier = Modifier
                            .fillMaxWidth()
                            .padding(top = 48.dp),
                        text = stringResource(R.string.no_search_results, query),
                        style = MaterialTheme.typography.bodyLarge,
                        color = MaterialTheme.colorScheme.onSurfaceVariant,
                        textAlign = TextAlign.Center,
                        maxLines = 3,
                        overflow = TextOverflow.Ellipsis
                    )
                }
            }

            items(
                items = listItems,
                key = { it.key },
                contentType = { it.contentType }
            ) { item ->
                when (item) {
                    is HeaderItem -> Text(
                        item.titleChar.toString(),
                        fontSize = 11.sp
                    )

                    is BirthdayItem -> {
                        ConfirmDialog(
                            title = stringResource(
                                R.string.delete_birthday
                            ),
                            content = stringResource(
                                R.string.delete_birthday_confirm_dialog_body,
                                item.data.contactInfo.name
                            ),
                            confirmText = stringResource(
                                R.string.delete_btn
                            ),
                            dismissText = stringResource(
                                R.string.keep_birthday_btn
                            ),
                            isDestructiveAction = true,
                            onConfirm = { onDeleteBirthday(item.data.id) },
                            trigger = { openDialog ->
                                var menuExpanded by remember { mutableStateOf(false) }
                                val contactInfo = item.data.contactInfo

                                Box(modifier = Modifier.fillMaxWidth()) {
                                    ContactCard(
                                        onLongClick = {
                                            hapticFeedback.performHapticFeedback(
                                                HapticFeedbackType.LongPress
                                            )

                                            menuExpanded = true
                                        }
                                    ) {
                                        CircleAvatar(
                                            nameInitialChar =
                                                contactInfo
                                                    .name
                                                    .normalizedInitial,
                                            size = 48.dp
                                        )

                                        Column(
                                            modifier = Modifier.weight(1f),
                                            verticalArrangement = Arrangement.spacedBy(4.dp)
                                        ) {
                                            Text(
                                                text =
                                                    contactInfo
                                                        .name
                                                        .safeForDisplay,
                                                fontSize = 16.sp,
                                                overflow = TextOverflow.Ellipsis,
                                                maxLines = 1
                                            )

                                            Row(
                                                verticalAlignment = Alignment.CenterVertically,
                                                horizontalArrangement = Arrangement.spacedBy(8.dp)
                                            ) {
                                                val birthdayYear = item.data.birthday.year

                                                Text(
                                                    text =
                                                        if (birthdayYear != 0) formatter.formatShort(
                                                            item.data.birthday
                                                        )
                                                        else formatter.format(
                                                            birthday = item.data.birthday,
                                                            includeYear = false
                                                        ),
                                                    fontSize = 14.sp,
                                                    color = MaterialTheme.colorScheme.onSurfaceVariant
                                                )

                                                if (birthdayYear != 0) {
                                                    Text(
                                                        text = "•",
                                                        fontSize = 12.sp,
                                                        color = MaterialTheme
                                                            .colorScheme
                                                            .onSurfaceVariant
                                                    )
                                                    Text(
                                                        text = stringResource(
                                                            R.string.years_old,
                                                            currentYear - birthdayYear
                                                        ),
                                                        fontSize = 12.sp,
                                                        color = MaterialTheme.colorScheme.onSurfaceVariant
                                                    )
                                                }
                                            }

                                            if (item.data.note != null) {
                                                Text(
                                                    text = item.data.note,
                                                    fontSize = 12.sp,
                                                    color = MaterialTheme.colorScheme.onSurfaceVariant
                                                )
                                            }
                                        }

                                        val daysUntilBirthday = timeUntilBirthday(
                                            item.data.birthday.dayOfMonth,
                                            item.data.birthday.monthValue
                                        )

                                        val statusText = when (daysUntilBirthday) {
                                            0 -> stringResource(R.string.birthday_today)
                                            1 -> stringResource(R.string.birthday_tomorrow)
                                            in 2..30 -> stringResource(
                                                R.string.time_until_birthday_in_days,
                                                daysUntilBirthday
                                            )

                                            else -> {
                                                val monthsUntilBirthday = timeUntilBirthday(
                                                    item.data.birthday.dayOfMonth,
                                                    item.data.birthday.monthValue,
                                                    inMonths = true
                                                )

                                                stringResource(
                                                    R.string.time_until_birthday_in_months,
                                                    monthsUntilBirthday
                                                )
                                            }
                                        }

                                        StatusPill(
                                            text = statusText,
                                            color =
                                                if (daysUntilBirthday <= 3) Color.Red
                                                else MaterialTheme.colorScheme.onSurfaceVariant
                                        )
                                    }

                                    EditDeleteMenu(
                                        expanded = menuExpanded,
                                        onEdit = { onEditBirthday(item.data.id) },
                                        onDelete = openDialog,
                                        onDismiss = { menuExpanded = false }
                                    )
                                }
                            }
                        )
                    }
                }
            }
        }
    }
}

@Composable
private fun CenteredMessage(text: String) {
    Box(
        modifier = Modifier.fillMaxSize(),
        contentAlignment = Alignment.Center
    ) {
        Text(
            text = text,
            style = MaterialTheme.typography.bodyLarge,
            color = MaterialTheme.colorScheme.onSurfaceVariant,
            textAlign = TextAlign.Center
        )
    }
}

@Composable
private fun ErrorMessage(text: String, onRetry: () -> Unit) {
    Column(
        modifier = Modifier.fillMaxSize(),
        horizontalAlignment = Alignment.CenterHorizontally,
        verticalArrangement = Arrangement.spacedBy(
            16.dp,
            Alignment.CenterVertically
        )
    ) {
        Text(
            text = text,
            style = MaterialTheme.typography.bodyLarge,
            color = MaterialTheme.colorScheme.onSurfaceVariant,
            textAlign = TextAlign.Center
        )

        Button(onClick = onRetry) {
            Text(stringResource(R.string.retry))
        }
    }
}