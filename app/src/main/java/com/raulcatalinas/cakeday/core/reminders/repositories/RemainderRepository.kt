package com.raulcatalinas.cakeday.core.reminders.repositories

import android.Manifest
import android.app.PendingIntent
import android.content.Context
import android.content.Intent
import android.content.pm.PackageManager
import android.os.Build
import android.util.Log
import androidx.core.app.NotificationCompat
import androidx.core.app.NotificationManagerCompat
import androidx.core.content.ContextCompat
import com.raulcatalinas.cakeday.R
import com.raulcatalinas.cakeday.core.reminders.constants.REMAINDER_REPOSITORY_TAG
import com.raulcatalinas.cakeday.core.reminders.constants.REMINDER_NOTIFICATIONS_CHANNEL_ID
import com.raulcatalinas.cakeday.services.AppAlarmManager
import com.raulcatalinas.cakeday.services.OpenWhatsAppActivity
import com.raulcatalinas.cakeday.services.constants.EXTRA_MESSAGE
import com.raulcatalinas.cakeday.services.constants.EXTRA_NAME
import com.raulcatalinas.cakeday.services.constants.EXTRA_PHONE
import dagger.hilt.android.qualifiers.ApplicationContext
import java.time.LocalDate
import java.time.LocalTime
import javax.inject.Inject

class ReminderRepository @Inject constructor(
    @ApplicationContext private val context: Context,
    private val alarmManager: AppAlarmManager
) {
    fun deleteReminder(id: Int) {
        alarmManager.cancelAlarms(id)
    }

    fun scheduleReminder(
        id: Int,
        date: LocalDate,
        time: LocalTime,
        advanceNotice: Boolean
    ): Boolean {
        return alarmManager.setAlarm(
            id = id,
            date = date,
            time = time,
            advanceNotice = advanceNotice
        )
    }

    fun showNotification(
        id: Int,
        title: String,
        message: String,
        phone: String,
        name: String
    ): Boolean {
        if (
            Build.VERSION.SDK_INT
            >= Build.VERSION_CODES.TIRAMISU
            && ContextCompat.checkSelfPermission(
                context,
                Manifest.permission.POST_NOTIFICATIONS
            ) != PackageManager.PERMISSION_GRANTED
        ) {
            Log.w(
                REMAINDER_REPOSITORY_TAG,
                "POST_NOTIFICATIONS not granted: notification $id not shown"
            )

            return false
        }

        val openWhatsApp =
            Intent(context, OpenWhatsAppActivity::class.java)
                .putExtra(EXTRA_PHONE, phone)
                .putExtra(EXTRA_MESSAGE, message)
                .putExtra(EXTRA_NAME, name)

        val contentIntent = PendingIntent.getActivity(
            context,
            id,
            openWhatsApp,
            PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE
        )

        val notification =
            NotificationCompat
                .Builder(
                    context,
                    REMINDER_NOTIFICATIONS_CHANNEL_ID
                )
                .setSmallIcon(R.mipmap.ic_launcher)
                .setContentTitle(title)
                .setContentText(message)
                .setCategory(NotificationCompat.CATEGORY_REMINDER)
                .setContentIntent(contentIntent)
                .setAutoCancel(true)
                .build()

        NotificationManagerCompat
            .from(context)
            .notify(
                id,
                notification
            )

        return true
    }
}