package com.raulcatalinas.cakeday.shared.utils

import java.time.LocalDate
import java.time.temporal.ChronoUnit

fun timeUntilBirthday(
    day: Int,
    month: Int,
    inMonths: Boolean = false
): Int {
    val today = LocalDate.now()
    var next = LocalDate.of(
        today.year,
        month,
        day
    )

    if (next.isBefore(today)) {
        next = LocalDate.of(
            today.year + 1,
            month,
            day
        )
    }

    if (inMonths) {
        return ChronoUnit
            .MONTHS
            .between(
                today,
                next
            )
            .toInt()
    }

    return ChronoUnit
        .DAYS
        .between(
            today,
            next
        )
        .toInt()
}