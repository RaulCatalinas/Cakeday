package com.raulcatalinas.cakeday.shared.types

import androidx.compose.runtime.Immutable

@Immutable
data class ContactInfo(
    val name: String,
    val phone: String
)
