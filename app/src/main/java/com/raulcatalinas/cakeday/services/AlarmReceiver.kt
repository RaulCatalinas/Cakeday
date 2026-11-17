package com.raulcatalinas.cakeday.services

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.util.Log
import com.raulcatalinas.cakeday.R
import com.raulcatalinas.cakeday.core.birthdays.repositories.BirthdayRepository
import com.raulcatalinas.cakeday.core.reminders.repositories.ReminderRepository
import com.raulcatalinas.cakeday.screens.settings.repositories.SettingsRepository
import com.raulcatalinas.cakeday.services.constants.ALARM_RECEIVER_TAG
import com.raulcatalinas.cakeday.services.constants.EXTRA_BIRTHDAY_ID
import com.raulcatalinas.cakeday.services.constants.NAME_PLACEHOLDER
import dagger.hilt.EntryPoint
import dagger.hilt.InstallIn
import dagger.hilt.android.EntryPointAccessors
import dagger.hilt.components.SingletonComponent
import kotlinx.coroutines.CancellationException
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.flow.first
import kotlinx.coroutines.launch
import kotlinx.datetime.LocalTime

// What the receiver needs from Hilt. It is asked for explicitly, so the
// receiver does not depend on a generated base class.
@EntryPoint
@InstallIn(SingletonComponent::class)
interface AlarmReceiverEntryPoint {
    fun birthdayRepository(): BirthdayRepository

    fun settingsRepository(): SettingsRepository

    fun reminderRepository(): ReminderRepository

    fun appAlarmManager(): AppAlarmManager
}

class AlarmReceiver : BroadcastReceiver() {
    override fun onReceive(context: Context, intent: Intent) {
        val id = intent.getIntExtra(
            EXTRA_BIRTHDAY_ID,
            -1
        )

        if (id == -1) return

        val entryPoint = EntryPointAccessors.fromApplication(
            context.applicationContext,
            AlarmReceiverEntryPoint::class.java
        )

        // Reading the database is not instant: goAsync keeps the receiver alive
        // until finish() is called (the system gives it about 10 seconds).
        val pendingResult = goAsync()

        CoroutineScope(Dispatchers.Default).launch {
            try {
                handle(context, id, entryPoint)
            } catch (e: CancellationException) {
                throw e
            } catch (e: Exception) {
                Log.e(
                    ALARM_RECEIVER_TAG,
                    "Error handling the alarm of $id: ${e.message}",
                    e
                )
            } finally {
                pendingResult.finish()
            }
        }
    }

    private suspend fun handle(
        context: Context,
        id: Int,
        entryPoint: AlarmReceiverEntryPoint
    ) {
        val birthday =
            entryPoint
                .birthdayRepository()
                .getBirthdayById(id)

        // It was deleted after the alarm was set: there is nothing to show.
        if (birthday == null) {
            Log.w(
                ALARM_RECEIVER_TAG,
                "Birthday $id not found: no notification"
            )

            return
        }

        val settings =
            entryPoint
                .settingsRepository()
                .getSettings()
                .first()

        // Reminders are off in the settings: no notification and no next year.
        if (!settings.notificationsEnabled) return

        // The next year goes first, so a failure while showing this one does
        // not break the chain of alarms.
        entryPoint
            .appAlarmManager()
            .setAlarm(
                id = id,
                date = birthday.birthday,
                time = LocalTime(
                    birthday.notificationHour,
                    birthday.notificationMinute,
                    0
                )
            )

        val name = birthday.contactInfo.name

        // The message is chosen now, so a change in the settings is used.
        val template =
            birthday.personalisedMessage
                ?: settings.globalMessage
                ?: context.getString(
                    R.string.default_global_message
                )

        entryPoint
            .reminderRepository()
            .showNotification(
                id = id,
                title = context.getString(
                    R.string.birthday_notification_title
                ),
                message = template.replace(
                    NAME_PLACEHOLDER,
                    name
                )
            )
    }
}