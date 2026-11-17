package com.raulcatalinas.cakeday

import android.app.Application
import android.app.NotificationChannel
import android.app.NotificationManager
import com.raulcatalinas.cakeday.core.reminders.constants.REMINDER_NOTIFICATIONS_CHANNEL_ID
import dagger.hilt.android.HiltAndroidApp

@HiltAndroidApp
class CakedayApplication : Application() {
    override fun onCreate() {
        super.onCreate()

        getSystemService(NotificationManager::class.java)
            .createNotificationChannel(
                NotificationChannel(
                    REMINDER_NOTIFICATIONS_CHANNEL_ID,
                    "Birthday reminders",
                    NotificationManager.IMPORTANCE_DEFAULT
                )
            )
    }
}