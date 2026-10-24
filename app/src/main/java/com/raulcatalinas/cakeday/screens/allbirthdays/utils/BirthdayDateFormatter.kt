package com.raulcatalinas.cakeday.screens.allbirthdays.utils

import android.text.format.DateFormat
import kotlinx.datetime.TimeZone
import kotlinx.datetime.toJavaLocalDate
import kotlinx.datetime.toLocalDateTime
import java.time.format.DateTimeFormatter
import java.util.Locale
import kotlin.time.Instant

class BirthdayDateFormatter(locale: Locale) {
    private val withYear = DateTimeFormatter.ofPattern(
        DateFormat.getBestDateTimePattern(locale, "dMMMMy"), locale
    )
    private val withoutYear = DateTimeFormatter.ofPattern(
        DateFormat.getBestDateTimePattern(locale, "dMMMM"), locale
    )

    fun format(birthday: Instant, includeYear: Boolean): String {
        val date =
            birthday
                .toLocalDateTime(TimeZone.UTC)
                .date
                .toJavaLocalDate()

        return date.format(
            if (includeYear) withYear
            else withoutYear
        )
    }
}