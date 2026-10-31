package com.raulcatalinas.cakeday.shared.models

import com.raulcatalinas.cakeday.shared.types.ContactInfo
import java.time.LocalDate

data class BirthdayModel(
    val id: Int = 0,
    val contactInfo: ContactInfo,
    val birthday: LocalDate,
    val personalisedMessage: String? = null,
    val note: String? = null,
    val notificationHour: Int = 9,
    val notificationMinute: Int = 0,
    val notificationScheduled: Boolean = false,
    val createdAt: Long = System.currentTimeMillis(),
    val updatedAt: Long = System.currentTimeMillis()
)