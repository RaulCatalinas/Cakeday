package com.raulcatalinas.cakeday.screens.allbirthdays.types

import com.raulcatalinas.cakeday.shared.models.BirthdayModel

class BirthdayEntry(
    val data: BirthdayModel,
    val initial: Char,
    val dateText: String,
    val searchText: String
)