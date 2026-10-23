package com.raulcatalinas.cakeday.screens.settings

import androidx.compose.foundation.background
import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.rememberScrollState
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.foundation.verticalScroll
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.automirrored.filled.ArrowForwardIos
import androidx.compose.material.icons.filled.AddAlert
import androidx.compose.material.icons.filled.Alarm
import androidx.compose.material.icons.filled.CalendarMonth
import androidx.compose.material3.Card
import androidx.compose.material3.HorizontalDivider
import androidx.compose.material3.Icon
import androidx.compose.material3.Scaffold
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.vector.ImageVector
import androidx.compose.ui.res.stringResource
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import androidx.hilt.lifecycle.viewmodel.compose.hiltViewModel
import androidx.lifecycle.compose.collectAsStateWithLifecycle
import com.raulcatalinas.cakeday.R
import com.raulcatalinas.cakeday.screens.settings.enums.LanguageOptions
import com.raulcatalinas.cakeday.screens.settings.enums.ThemeOptions
import com.raulcatalinas.cakeday.screens.settings.viewmodels.SettingsViewModel
import com.raulcatalinas.cakeday.shared.components.AppSwitch
import com.raulcatalinas.cakeday.shared.components.AppTimePicker
import com.raulcatalinas.cakeday.shared.components.MessagePreview
import com.raulcatalinas.cakeday.shared.components.SectionHeader
import com.raulcatalinas.cakeday.shared.components.SegmentedButton
import com.raulcatalinas.cakeday.shared.components.Subtitle
import com.raulcatalinas.cakeday.shared.extensions.verticalScrollbar

@Composable
fun SettingsScreen(viewModel: SettingsViewModel = hiltViewModel()) {
    val scrollState = rememberScrollState()

    val settings by viewModel.settings.collectAsStateWithLifecycle()

    val themeOptions = ThemeOptions.entries.toList()
    val languageOptions = LanguageOptions.entries.toList()

    Scaffold { paddingValues ->
        Column(
            modifier = Modifier
                .padding(paddingValues)
                .verticalScrollbar(scrollState)
                .verticalScroll(scrollState)
                .padding(horizontal = 20.dp, vertical = 16.dp)
                .fillMaxSize(),
            horizontalAlignment = Alignment.Start,
            verticalArrangement = Arrangement.spacedBy(16.dp),
        ) {
            SectionHeader(stringResource(R.string.global_message_section_title))

            MessagePreview(
                initialMessage =
                    settings.globalMessage
                        ?: stringResource(R.string.default_global_message)
            ) {
                viewModel.setGlobalMessage(it)
            }

            SectionHeader(stringResource(R.string.notifications_section_title))

            Card(
                modifier = Modifier.fillMaxWidth(),
                shape = RoundedCornerShape(16.dp)
            ) {
                SettingItem(
                    icon = Icons.Default.AddAlert,
                    iconColor = Color(0xFFFF9500),
                    title = stringResource(R.string.enable_notifications),
                    subtitle = stringResource(R.string.enable_notifications_subtitle)
                ) {
                    AppSwitch(
                        initialValue = settings.notificationsEnabled,
                        preOnChanged = {
                            println("Asking user for permission")

                            return@AppSwitch true
                        }
                    ) {
                        viewModel.setNotificationsEnabled(it)
                    }
                }

                SettingDivider()

                AppTimePicker(
                    initialTime = settings.notificationTime,
                    trigger = { open ->
                        SettingItem(
                            modifier = Modifier.clickable(onClick = open),
                            icon = Icons.Default.Alarm,
                            iconColor = Color(0xFFFF3B30),
                            title = stringResource(R.string.notification_time),
                            subtitle = stringResource(R.string.notification_time_subtitle)
                        ) {
                            Row(
                                horizontalArrangement = Arrangement.spacedBy(8.dp),
                                verticalAlignment = Alignment.CenterVertically
                            ) {
                                Text(
                                    "%02d:%02d".format(
                                        settings.notificationTime.hour,
                                        settings.notificationTime.minute
                                    )
                                )
                                Icon(
                                    Icons.AutoMirrored.Filled.ArrowForwardIos,
                                    contentDescription = null
                                )
                            }
                        }
                    }
                ) {
                    viewModel.setNotificationTime(it)
                }

                SettingDivider()

                SettingItem(
                    icon = Icons.Default.CalendarMonth,
                    iconColor = Color(0xFF0A84FF),
                    title = stringResource(R.string.advance_notice),
                    subtitle = stringResource(R.string.advance_notice_subtitle)
                ) {
                    AppSwitch(initialValue = settings.advanceNotice) {
                        viewModel.setAdvanceNotice(it)
                    }
                }
            }

            SectionHeader(stringResource(R.string.appearance_section_title))

            SegmentedButton(
                options = themeOptions,
                selectedOption = settings.theme,
                onOptionSelected = { newTheme ->
                    viewModel.setTheme(newTheme)
                },
                label = { stringResource(it.labelRes) }
            )

            SectionHeader(stringResource(R.string.language_section_title))

            SegmentedButton(
                options = languageOptions,
                selectedOption = viewModel.getCurrentLanguage(),
                onOptionSelected = { newLanguage ->
                    viewModel.setLanguage(newLanguage)
                },
                label = { stringResource(it.labelRes) }
            )
        }
    }
}

@Composable
private fun SettingItem(
    icon: ImageVector,
    iconColor: Color,
    title: String,
    subtitle: String,
    modifier: Modifier = Modifier,
    trailing: @Composable () -> Unit = {}
) {
    Row(
        modifier = modifier
            .fillMaxWidth()
            .padding(horizontal = 16.dp, vertical = 12.dp),
        horizontalArrangement = Arrangement.spacedBy(12.dp),
        verticalAlignment = Alignment.CenterVertically
    ) {
        Box(
            modifier = Modifier
                .size(40.dp)
                .background(iconColor.copy(alpha = 0.15f), RoundedCornerShape(10.dp)),
            contentAlignment = Alignment.Center
        ) {
            Icon(icon, contentDescription = null, tint = iconColor)
        }

        Column(
            modifier = Modifier.weight(1f),
            verticalArrangement = Arrangement.spacedBy(2.dp)
        ) {
            Text(text = title, fontSize = 18.sp, fontWeight = FontWeight.SemiBold)
            Subtitle(subtitle)
        }

        trailing()
    }
}

@Composable
private fun SettingDivider(modifier: Modifier = Modifier) {
    HorizontalDivider(modifier = modifier.padding(start = 16.dp, end = 16.dp))
}