package com.raulcatalinas.cakeday.screens.settings.types

import com.raulcatalinas.cakeday.screens.settings.enums.ThemeOptions
import kotlinx.datetime.LocalTime

data class AppSettings(
    val theme: ThemeOptions = ThemeOptions.System,
    val notificationsEnabled: Boolean,
    val notificationTime: LocalTime,
    val advanceNotice: Boolean,
    val globalMessage: String?
)