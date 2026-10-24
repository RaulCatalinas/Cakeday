package com.raulcatalinas.cakeday.screens.allbirthdays.types

import com.raulcatalinas.cakeday.shared.types.BirthdayData

sealed interface AllBirthdaysItem {
    val key: String
    val contentType: String
}

data class HeaderItem(val titleChar: Char) : AllBirthdaysItem {
    override val key = "header_$titleChar"
    override val contentType = "header"
}

data class BirthdayItem(val data: BirthdayData, val dateText: String) : AllBirthdaysItem {
    override val key = "birthday_${data.id}"
    override val contentType = "birthday"
}