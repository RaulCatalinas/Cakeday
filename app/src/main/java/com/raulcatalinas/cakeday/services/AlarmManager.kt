package com.raulcatalinas.cakeday.services

import android.app.AlarmManager
import android.app.PendingIntent
import android.content.Context
import android.content.Intent
import android.util.Log
import com.raulcatalinas.cakeday.core.reminders.constants.NOTIFICATION_ID_OFFSET
import com.raulcatalinas.cakeday.services.constants.ALARM_MANAGER_TAG
import com.raulcatalinas.cakeday.services.constants.EXTRA_BIRTHDAY_ID
import dagger.hilt.android.qualifiers.ApplicationContext
import kotlinx.datetime.LocalTime
import kotlinx.datetime.toJavaLocalTime
import java.time.LocalDate
import java.time.YearMonth
import java.time.ZoneId
import java.time.ZonedDateTime
import javax.inject.Inject

class AppAlarmManager @Inject constructor(
    @ApplicationContext private val context: Context
) {
    private val alarmManager = context.getSystemService(AlarmManager::class.java)

    fun setAlarm(id: Int, date: LocalDate, time: LocalTime): Boolean {
        if (!alarmManager.canScheduleExactAlarms()) {
            Log.w(
                ALARM_MANAGER_TAG,
                "Exact alarms not allowed: alarm for $id not scheduled"
            )

            return false
        }

        val triggerAtMillis =
            nextOccurrence(
                date,
                time,
                ZonedDateTime.now(
                    ZoneId.systemDefault()
                )
            )
                .toInstant()
                .toEpochMilli()

        return try {
            alarmManager.setExactAndAllowWhileIdle(
                AlarmManager.RTC_WAKEUP,
                triggerAtMillis,
                pendingIntent(id)
            )

            true
        } catch (e: SecurityException) {
            // The permission was taken away between the check and the call.
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
            pendingIntent(id)
        )
        alarmManager.cancel(
            pendingIntent(id + NOTIFICATION_ID_OFFSET)
        )
    }

    // The id is the request code, so each birthday has its own alarm: calling
    // setAlarm again for the same id replaces it, and cancelAlarms finds it.
    // The receiver only gets the id and reads the rest from the database.
    private fun pendingIntent(id: Int): PendingIntent =
        PendingIntent.getBroadcast(
            context,
            id,
            Intent(
                context,
                AlarmReceiver::class.java
            )
                .putExtra(EXTRA_BIRTHDAY_ID, id),
            PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE
        )
}

// First moment after [now] in which the day and month of [birthday] come at [time].
internal fun nextOccurrence(
    birthday: LocalDate,
    time: LocalTime,
    now: ZonedDateTime
): ZonedDateTime {
    val javaTime = time.toJavaLocalTime()

    // This year if it has not passed yet, and next year otherwise.
    for (year in now.year..now.year + 1) {
        val yearMonth = YearMonth.of(year, birthday.month)

        // A 29 of February is celebrated on the 28th in years that are not leap.
        val day = minOf(birthday.dayOfMonth, yearMonth.lengthOfMonth())

        val candidate = ZonedDateTime.of(yearMonth.atDay(day), javaTime, now.zone)

        if (candidate.isAfter(now)) return candidate
    }

    // Not reachable: next year is always in the future.
    error("No next occurrence found for $birthday")
}