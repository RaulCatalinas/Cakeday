package com.raulcatalinas.cakeday.screens.createbirthday.types

sealed interface SaveReminderResult {
    data object Saved : SaveReminderResult
    data object SavedWithoutReminder : SaveReminderResult
    data class Failed(val cause: Throwable) : SaveReminderResult
}