package com.raulcatalinas.cakeday.core.birthdays.models

data class SaveBirthdayData(
    val birthdayId: Long,
    val reminderScheduled: Boolean
)