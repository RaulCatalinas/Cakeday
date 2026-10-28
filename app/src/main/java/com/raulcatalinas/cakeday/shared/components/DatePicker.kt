package com.raulcatalinas.cakeday.shared.components

import androidx.compose.foundation.background
import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.aspectRatio
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.lazy.grid.GridCells
import androidx.compose.foundation.lazy.grid.LazyVerticalGrid
import androidx.compose.foundation.lazy.grid.items
import androidx.compose.foundation.lazy.grid.rememberLazyGridState
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.ChevronLeft
import androidx.compose.material.icons.filled.ChevronRight
import androidx.compose.material3.AlertDialog
import androidx.compose.material3.Icon
import androidx.compose.material3.IconButton
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Text
import androidx.compose.material3.TextButton
import androidx.compose.runtime.Composable
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableIntStateOf
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.rememberCoroutineScope
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.platform.LocalConfiguration
import androidx.compose.ui.res.stringResource
import androidx.compose.ui.unit.dp
import androidx.compose.ui.window.Dialog
import androidx.compose.ui.window.DialogProperties
import com.kizitonwose.calendar.compose.HorizontalCalendar
import com.kizitonwose.calendar.compose.rememberCalendarState
import com.kizitonwose.calendar.core.DayPosition
import com.kizitonwose.calendar.core.OutDateStyle
import com.raulcatalinas.cakeday.R
import kotlinx.coroutines.launch
import java.time.LocalDate
import java.time.YearMonth
import java.time.format.TextStyle

private val CalendarAccent = Color(0xFFFF6B6B)

@Composable
fun AppDatePicker(
    trigger: @Composable (open: () -> Unit) -> Unit,
    onSelectedDate: (LocalDate?) -> Unit
) {
    val coroutineScope = rememberCoroutineScope()
    val locale = LocalConfiguration.current.locales[0]

    val today = remember { LocalDate.now() }
    val currentMonth = remember { YearMonth.from(today) }
    val firstMonth = remember { YearMonth.of(1900, 1) }
    val lastMonth = remember { YearMonth.of(currentMonth.year, 12) }
    val months = remember { (1..12).toList() }

    val years = remember(currentMonth.year) {
        (currentMonth.year downTo firstMonth.year).toList()
    }

    var showCalendar by remember { mutableStateOf(false) }
    var showMonthSelector by remember { mutableStateOf(false) }
    var showYearSelector by remember { mutableStateOf(false) }

    var selectedDate by remember { mutableStateOf(today) }
    var pendingDate by remember { mutableStateOf(today) }
    var selectedYear by remember { mutableIntStateOf(currentMonth.year) }

    val state = rememberCalendarState(
        startMonth = firstMonth,
        endMonth = lastMonth,
        firstVisibleMonth = currentMonth,
        outDateStyle = OutDateStyle.EndOfGrid
    )

    val visibleMonth = state.firstVisibleMonth.yearMonth
    val yearGridState = rememberLazyGridState()

    LaunchedEffect(showYearSelector, selectedYear) {
        if (!showYearSelector) return@LaunchedEffect

        yearGridState.scrollToItem(currentMonth.year - selectedYear)
    }

    trigger {
        pendingDate = selectedDate
        showMonthSelector = false
        showYearSelector = false
        showCalendar = true
    }

    if (!showCalendar) return

    Dialog(
        onDismissRequest = {
            showCalendar = false
            showMonthSelector = false
            showYearSelector = false
        },
        properties = DialogProperties(usePlatformDefaultWidth = false)
    ) {
        Column(
            modifier = Modifier
                .fillMaxWidth()
                .padding(16.dp)
                .background(
                    color = MaterialTheme.colorScheme.surface,
                    shape = MaterialTheme.shapes.extraLarge
                )
                .padding(16.dp)
        ) {
            Row(
                modifier = Modifier.fillMaxWidth(),
                verticalAlignment = Alignment.CenterVertically,
                horizontalArrangement = Arrangement.SpaceBetween
            ) {
                IconButton(
                    enabled = visibleMonth > firstMonth,
                    onClick = {
                        coroutineScope.launch {
                            state.animateScrollToMonth(
                                visibleMonth.minusMonths(1)
                            )
                        }
                    }
                ) {
                    Icon(
                        imageVector = Icons.Default.ChevronLeft,
                        contentDescription = stringResource(R.string.previous_month)
                    )
                }

                TextButton(
                    onClick = {
                        selectedYear = visibleMonth.year
                        showMonthSelector = true
                        showYearSelector = false
                    }
                ) {
                    Text(
                        text = "${
                            visibleMonth.month.getDisplayName(
                                TextStyle.FULL,
                                locale
                            ).replaceFirstChar { it.uppercase(locale) }
                        } ${visibleMonth.year}",
                        style = MaterialTheme.typography.titleMedium
                    )
                }

                IconButton(
                    enabled = visibleMonth < lastMonth,
                    onClick = {
                        coroutineScope.launch {
                            state.animateScrollToMonth(
                                visibleMonth.plusMonths(1)
                            )
                        }
                    }
                ) {
                    Icon(
                        imageVector = Icons.Default.ChevronRight,
                        contentDescription = stringResource(R.string.next_month)
                    )
                }
            }

            HorizontalCalendar(
                state = state,
                dayContent = { day ->
                    if (day.position == DayPosition.MonthDate) {
                        val isSelected = day.date == pendingDate
                        val isToday = day.date == today

                        Box(
                            modifier = Modifier
                                .aspectRatio(1f)
                                .padding(4.dp)
                                .clip(CircleShape)
                                .background(
                                    if (isSelected) CalendarAccent
                                    else Color.Transparent
                                )
                                .clickable {
                                    pendingDate = day.date
                                },
                            contentAlignment = Alignment.Center
                        ) {
                            Text(
                                text = day.date.dayOfMonth.toString(),
                                color = when {
                                    isSelected -> Color.White
                                    isToday -> CalendarAccent
                                    else -> MaterialTheme.colorScheme.onSurface
                                }
                            )
                        }
                    }
                }
            )

            Row(
                modifier = Modifier.fillMaxWidth(),
                horizontalArrangement = Arrangement.End
            ) {
                TextButton(
                    onClick = {
                        showCalendar = false
                        showMonthSelector = false
                        showYearSelector = false
                    }
                ) {
                    Text(
                        stringResource(
                            android.R.string.cancel
                        )
                    )
                }

                TextButton(
                    onClick = {
                        selectedDate = pendingDate

                        onSelectedDate(selectedDate)

                        showCalendar = false
                        showMonthSelector = false
                        showYearSelector = false
                    }
                ) {
                    Text(
                        stringResource(
                            android.R.string.ok
                        )
                    )
                }
            }
        }
    }

    if (showMonthSelector) {
        AlertDialog(
            onDismissRequest = {
                showMonthSelector = false
                showYearSelector = false
            },
            title = title@{
                if (showYearSelector) {
                    Text(
                        stringResource(
                            R.string.select_year
                        )
                    )

                    return@title
                }

                Row(
                    modifier = Modifier.fillMaxWidth(),
                    verticalAlignment = Alignment.CenterVertically,
                    horizontalArrangement = Arrangement.SpaceBetween
                ) {
                    IconButton(
                        enabled = selectedYear > firstMonth.year,
                        onClick = { selectedYear-- }
                    ) {
                        Icon(
                            imageVector = Icons.Default.ChevronLeft,
                            contentDescription = stringResource(
                                R.string.previous_year
                            )
                        )
                    }

                    TextButton(
                        onClick = { showYearSelector = true }
                    ) {
                        Text(
                            text = selectedYear.toString(),
                            style = MaterialTheme.typography.titleLarge
                        )
                    }

                    IconButton(
                        enabled = selectedYear < currentMonth.year,
                        onClick = { selectedYear++ }
                    ) {
                        Icon(
                            imageVector = Icons.Default.ChevronRight,
                            contentDescription = stringResource(
                                R.string.next_year
                            )
                        )
                    }
                }
            },
            text = text@{
                if (showYearSelector) {
                    LazyVerticalGrid(
                        columns = GridCells.Fixed(4),
                        state = yearGridState,
                        modifier = Modifier.height(300.dp),
                        verticalArrangement = Arrangement.spacedBy(4.dp),
                        horizontalArrangement = Arrangement.spacedBy(4.dp)
                    ) {
                        items(
                            items = years,
                            key = { year -> year }
                        ) { year ->
                            TextButton(
                                onClick = {
                                    selectedYear = year
                                    showYearSelector = false
                                }
                            ) {
                                Text(
                                    text = year.toString(),
                                    color =
                                        if (year == selectedYear) CalendarAccent
                                        else MaterialTheme.colorScheme.onSurface
                                )
                            }
                        }
                    }

                    return@text
                }

                LazyVerticalGrid(
                    columns = GridCells.Fixed(3),
                    verticalArrangement = Arrangement.spacedBy(8.dp),
                    horizontalArrangement = Arrangement.spacedBy(8.dp)
                ) {
                    items(
                        items = months,
                        key = { monthNumber -> monthNumber }
                    ) { monthNumber ->
                        val month = YearMonth.of(selectedYear, monthNumber)
                        val enabled = month in firstMonth..lastMonth
                        val isCurrentMonth = month == visibleMonth

                        TextButton(
                            enabled = enabled,
                            onClick = {
                                coroutineScope.launch {
                                    state.scrollToMonth(month)
                                    showMonthSelector = false
                                }
                            }
                        ) {
                            Text(
                                text = month.month.getDisplayName(
                                    TextStyle.SHORT,
                                    locale
                                ).replaceFirstChar { it.uppercase(locale) },
                                color =
                                    if (isCurrentMonth) CalendarAccent
                                    else MaterialTheme.colorScheme.onSurface
                            )
                        }
                    }
                }
            },
            confirmButton = {
                TextButton(
                    onClick = {
                        if (showYearSelector) showYearSelector = false
                        else showMonthSelector = false
                    }
                ) {
                    Text(
                        stringResource(
                            android.R.string.cancel
                        )
                    )
                }
            }
        )
    }
}
