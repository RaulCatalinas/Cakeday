package com.raulcatalinas.cakeday.shared.types

import androidx.compose.runtime.Immutable
import kotlin.time.Instant

@Immutable
data class BirthdayData(
    val id: Int,
    val contactInfo: ContactInfo,
    val birthday: Instant,
    val includeYear: Boolean = false,
    val note: String? = null,
    val notificationScheduled: Boolean = false
)
