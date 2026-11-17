package com.raulcatalinas.cakeday.core.reminders.repositories

import android.Manifest
import android.content.Context
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
import dagger.hilt.android.qualifiers.ApplicationContext
import javax.inject.Inject

class ReminderRepository @Inject constructor(
    @ApplicationContext private val context: Context,
    private val alarmManager: AppAlarmManager
) {
    fun deleteReminder(id: Int) {
        alarmManager.cancelAlarms(id)
    }

    fun showNotification(
        id: Int,
        title: String,
        message: String
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