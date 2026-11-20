package com.raulcatalinas.cakeday.services

import android.app.AlarmManager
import android.app.PendingIntent
import android.content.Context
import android.content.Intent
import android.util.Log
import com.raulcatalinas.cakeday.core.reminders.constants.NOTIFICATION_ID_OFFSET
import com.raulcatalinas.cakeday.services.constants.ALARM_MANAGER_TAG
import com.raulcatalinas.cakeday.services.constants.EXTRA_BIRTHDAY_ID
import com.raulcatalinas.cakeday.services.constants.EXTRA_IS_ADVANCE_NOTICE
import dagger.hilt.android.qualifiers.ApplicationContext
import java.time.LocalDate
import java.time.LocalTime
import java.time.YearMonth
import java.time.ZoneId
import java.time.ZonedDateTime
import javax.inject.Inject

class AppAlarmManager @Inject constructor(
    @ApplicationContext private val context: Context
) {
    private val alarmManager = context.getSystemService(
        AlarmManager::class.java
    )

    fun setAlarm(
        id: Int,
        date: LocalDate,
        time: LocalTime,
        advanceNotice: Boolean
    ): Boolean {
        val now = ZonedDateTime.now(
            ZoneId.systemDefault()
        )

        val triggerAtMillis = nextOccurrence(
            date,
            time,
            now
        )
            .toInstant()
            .toEpochMilli()

        return try {
            alarmManager.setExactAndAllowWhileIdle(
                AlarmManager.RTC_WAKEUP,
                triggerAtMillis,
                pendingIntent(
                    birthdayId = id,
                    requestCode = id,
                    isAdvanceNotice = false
                )
            )

            if (advanceNotice) {
                val triggerAdvanceAtMillis = nextAdvanceOccurrence(
                    date,
                    time,
                    now
                )
                    .toInstant()
                    .toEpochMilli()

                alarmManager.setExactAndAllowWhileIdle(
                    AlarmManager.RTC_WAKEUP,
                    triggerAdvanceAtMillis,
                    pendingIntent(
                        birthdayId = id,
                        requestCode = id + NOTIFICATION_ID_OFFSET,
                        isAdvanceNotice = true
                    )
                )
            } else {
                alarmManager.cancel(
                    pendingIntent(
                        birthdayId = id,
                        requestCode = id + NOTIFICATION_ID_OFFSET,
                        isAdvanceNotice = true
                    )
                )
            }

            true
        } catch (e: SecurityException) {
            Log.e(
                ALARM_MANAGER_TAG,
                "Couldn't schedule the alarm for $id: ${e.message}",
                e
            )
            false
        }
    }

    fun cancelAlarms(id: Int) {
        alarmManager.cancel(
            pendingIntent(
                birthdayId = id,
                requestCode = id,
                isAdvanceNotice = false
            )
        )

        alarmManager.cancel(
            pendingIntent(
                birthdayId = id,
                requestCode = id + NOTIFICATION_ID_OFFSET,
                isAdvanceNotice = true
            )
        )
    }

    fun canScheduleExactAlarms(): Boolean {
        return alarmManager.canScheduleExactAlarms()
    }

    private fun pendingIntent(
        birthdayId: Int,
        requestCode: Int,
        isAdvanceNotice: Boolean
    ): PendingIntent {
        return PendingIntent.getBroadcast(
            context,
            requestCode,
            Intent(
                context,
                AlarmReceiver::class.java
            )
                .putExtra(EXTRA_BIRTHDAY_ID, birthdayId)
                .putExtra(EXTRA_IS_ADVANCE_NOTICE, isAdvanceNotice),
            PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE
        )
    }
}

// First moment after [now] in which the day and month of [birthday] come at [time].
internal fun nextOccurrence(
    birthday: LocalDate,
    time: LocalTime,
    now: ZonedDateTime
): ZonedDateTime {
    // This year if it has not passed yet, and next year otherwise.
    for (year in now.year..now.year + 1) {
        val yearMonth = YearMonth.of(year, birthday.month)

        // A 29 of February is celebrated on the 28th in years that are not leap.
        val day = minOf(birthday.dayOfMonth, yearMonth.lengthOfMonth())

        val candidate = ZonedDateTime.of(
            yearMonth.atDay(day),
            time,
            now.zone
        )

        if (candidate.isAfter(now)) return candidate
    }

    // Not reachable: next year is always in the future.
    error("No next occurrence found for $birthday")
}

internal fun nextAdvanceOccurrence(
    birthday: LocalDate,
    time: LocalTime,
    now: ZonedDateTime
): ZonedDateTime {
    val nextBirthday = nextOccurrence(birthday, time, now)

    val advanceOccurrence = nextBirthday.minusDays(1)

    return if (advanceOccurrence.isAfter(now)) {
        advanceOccurrence
    } else {
        nextOccurrence(
            birthday,
            time,
            nextBirthday
        ).minusDays(1)
    }
}
