package com.raulcatalinas.cakeday.shared.utils

import android.text.format.DateFormat
import kotlinx.datetime.TimeZone
import kotlinx.datetime.toJavaLocalDate
import kotlinx.datetime.toLocalDateTime
import java.time.LocalDate
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

    private val numericWithYear = DateTimeFormatter.ofPattern(
        DateFormat.getBestDateTimePattern(locale, "ddMMyyyy"), locale
    )
    private val numericWithoutYear = DateTimeFormatter.ofPattern(
        DateFormat.getBestDateTimePattern(locale, "ddMM"), locale
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

    fun format(birthday: LocalDate, includeYear: Boolean): String {
        return birthday.format(
            if (includeYear) withYear
            else withoutYear
        )
    }

    fun formatNumeric(birthday: Instant, includeYear: Boolean): String {
        val date =
            birthday
                .toLocalDateTime(TimeZone.UTC)
                .date
                .toJavaLocalDate()

        return date.format(
            if (includeYear) numericWithYear
            else numericWithoutYear
        )
    }

    fun formatNumeric(birthday: LocalDate, includeYear: Boolean): String {
        return birthday.format(
            if (includeYear) numericWithYear
            else numericWithoutYear
        )
    }
}