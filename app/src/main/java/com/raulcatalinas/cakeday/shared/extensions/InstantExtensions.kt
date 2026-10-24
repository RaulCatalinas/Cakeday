package com.raulcatalinas.cakeday.shared.extensions

import android.text.format.DateFormat
import kotlinx.datetime.TimeZone
import kotlinx.datetime.toJavaLocalDate
import kotlinx.datetime.toLocalDateTime
import java.time.format.DateTimeFormatter
import java.util.Locale
import kotlin.time.Instant

fun Instant.toDisplayDate(includeYear: Boolean, locale: Locale): String {
    val date = toLocalDateTime(TimeZone.UTC).date.toJavaLocalDate()

    val skeleton = if (includeYear) "dMMMMy" else "dMMMM"
    val pattern = DateFormat.getBestDateTimePattern(locale, skeleton)

    return date
        .format(
            DateTimeFormatter.ofPattern(
                pattern, locale
            )
        )
}