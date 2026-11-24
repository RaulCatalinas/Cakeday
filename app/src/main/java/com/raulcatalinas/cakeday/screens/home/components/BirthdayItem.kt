package com.raulcatalinas.cakeday.screens.home.components

import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.material3.Button
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.hapticfeedback.HapticFeedbackType
import androidx.compose.ui.platform.LocalConfiguration
import androidx.compose.ui.platform.LocalHapticFeedback
import androidx.compose.ui.platform.LocalResources
import androidx.compose.ui.text.style.TextOverflow
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import com.raulcatalinas.cakeday.R
import com.raulcatalinas.cakeday.shared.components.CircleAvatar
import com.raulcatalinas.cakeday.shared.components.ConfirmDialog
import com.raulcatalinas.cakeday.shared.components.ContactCard
import com.raulcatalinas.cakeday.shared.components.EditDeleteMenu
import com.raulcatalinas.cakeday.shared.components.StatusPill
import com.raulcatalinas.cakeday.shared.extensions.normalizedInitial
import com.raulcatalinas.cakeday.shared.extensions.safeForDisplay
import com.raulcatalinas.cakeday.shared.models.BirthdayModel
import com.raulcatalinas.cakeday.shared.utils.BirthdayDateFormatter
import com.raulcatalinas.cakeday.shared.utils.timeUntilBirthday
import java.time.LocalDate
import java.time.Period

@Composable
fun BirthdayItem(
    birthday: BirthdayModel,
    gradientEnabled: Boolean = false,
    onEditBirthday: (Int) -> Unit,
    onDeleteBirthday: (Int) -> Unit,
    onRetrySchedule: (BirthdayModel) -> Unit
) {
    val resources = LocalResources.current
    val hapticFeedback = LocalHapticFeedback.current

    val locale = LocalConfiguration.current.locales[0]
    val formatter = remember(locale) {
        BirthdayDateFormatter(locale)
    }

    val currentDate = LocalDate.now()

    val primaryTextColor = if (gradientEnabled) {
        Color(0xFF29212B)
    } else {
        MaterialTheme.colorScheme.onSurface
    }

    val secondaryTextColor = if (gradientEnabled) {
        Color(0xFF51444F)
    } else {
        MaterialTheme.colorScheme.onSurfaceVariant
    }

    val upcomingBirthdayColor = if (gradientEnabled) {
        Color.Red
    } else {
        Color(0xFFE53935)
    }

    ConfirmDialog(
        title = resources.getString(R.string.delete_birthday),
        content = resources.getString(
            R.string.delete_birthday_confirm_dialog_body,
            birthday.contactInfo.name
        ),
        confirmText = resources.getString(R.string.delete_btn),
        dismissText = resources.getString(R.string.keep_birthday_btn),
        isDestructiveAction = true,
        onConfirm = {
            onDeleteBirthday(birthday.id)
        },
        trigger = { openDialog ->
            var menuExpanded by remember { mutableStateOf(false) }

            val contactInfo = birthday.contactInfo

            Box(
                modifier = Modifier.fillMaxWidth()
            ) {
                ContactCard(
                    gradientEnabled = gradientEnabled,
                    onLongClick = {
                        hapticFeedback.performHapticFeedback(
                            HapticFeedbackType.LongPress
                        )
                        menuExpanded = true
                    }
                ) {
                    CircleAvatar(
                        nameInitialChar = contactInfo.name.normalizedInitial,
                        size = 48.dp,
                        contentColor = if (gradientEnabled) {
                            Color(0xFF29212B)
                        } else {
                            MaterialTheme.colorScheme.outline
                        }
                    )

                    Column(
                        modifier = Modifier.weight(1f),
                        verticalArrangement = Arrangement.spacedBy(4.dp)
                    ) {
                        Text(
                            text = contactInfo.name.safeForDisplay,
                            fontSize = 16.sp,
                            color = primaryTextColor,
                            overflow = TextOverflow.Ellipsis,
                            maxLines = 1
                        )

                        Row(
                            verticalAlignment = Alignment.CenterVertically,
                            horizontalArrangement = Arrangement.spacedBy(8.dp)
                        ) {
                            val birthdayYear = birthday.birthday.year

                            Text(
                                text = if (birthdayYear != 0) {
                                    formatter.formatShort(birthday.birthday)
                                } else {
                                    formatter.format(
                                        birthday = birthday.birthday,
                                        includeYear = false
                                    )
                                },
                                fontSize = 14.sp,
                                color = secondaryTextColor
                            )

                            if (birthdayYear != 0) {
                                Text(
                                    text = "•",
                                    fontSize = 12.sp,
                                    color = secondaryTextColor
                                )

                                Text(
                                    text = resources.getString(
                                        R.string.years_old,
                                        Period.between(
                                            birthday.birthday,
                                            currentDate
                                        ).years
                                    ),
                                    fontSize = 12.sp,
                                    color = secondaryTextColor
                                )
                            }
                        }

                        birthday.note?.let { note ->
                            Text(
                                text = note,
                                fontSize = 12.sp,
                                color = secondaryTextColor
                            )
                        }
                    }

                    val daysUntilBirthday = timeUntilBirthday(
                        birthday.birthday.dayOfMonth,
                        birthday.birthday.monthValue
                    )

                    val statusText = when (daysUntilBirthday) {
                        0 -> resources.getString(R.string.birthday_today)

                        1 -> resources.getString(R.string.birthday_tomorrow)

                        in 2..30 -> resources.getString(
                            R.string.time_until_birthday_in_days,
                            daysUntilBirthday
                        )

                        else -> {
                            val monthsUntilBirthday = timeUntilBirthday(
                                birthday.birthday.dayOfMonth,
                                birthday.birthday.monthValue,
                                inMonths = true
                            )

                            resources.getString(
                                R.string.time_until_birthday_in_months,
                                monthsUntilBirthday
                            )
                        }
                    }

                    Column(
                        verticalArrangement = Arrangement.spacedBy(8.dp),
                        horizontalAlignment = Alignment.CenterHorizontally
                    ) {
                        StatusPill(
                            text = statusText,
                            color = if (daysUntilBirthday <= 3) {
                                upcomingBirthdayColor
                            } else {
                                secondaryTextColor
                            }
                        )

                        if (!birthday.notificationScheduled) {
                            Button(
                                onClick = {
                                    onRetrySchedule(birthday)
                                }
                            ) {
                                Text(
                                    text = resources.getString(R.string.retry),
                                    fontSize = 16.sp
                                )
                            }
                        }
                    }
                }

                EditDeleteMenu(
                    expanded = menuExpanded,
                    onEdit = { onEditBirthday(birthday.id) },
                    onDelete = openDialog,
                    onDismiss = { menuExpanded = false }
                )
            }
        }
    )
}
