package com.raulcatalinas.cakeday.screens.createbirthday.repositories

import android.util.Log
import com.raulcatalinas.cakeday.screens.createbirthday.constants.CREATE_BIRTHDAY_REPOSITORY_TAG
import com.raulcatalinas.cakeday.screens.createbirthday.types.SaveReminderResult
import com.raulcatalinas.cakeday.shared.types.ContactInfo
import kotlinx.coroutines.CancellationException
import java.time.LocalDate
import javax.inject.Inject

class CreateBirthdayRepository @Inject constructor() {
    suspend fun saveReminder(
        birthday: LocalDate,
        contactInfo: ContactInfo,
        personalisedMessage: String?,
        note: String?
    ): SaveReminderResult {
        return try {
            // TODO(placeholder): insert the birthday in Room
            Log.i(
                CREATE_BIRTHDAY_REPOSITORY_TAG,
                "Saving reminder for ${contactInfo.name} ($birthday)..."
            )

            // TODO(placeholder): schedule the alarm. It must be false when it
            //  cannot be scheduled (for example, the user removed the permission).
            val reminderScheduled = true

            if (reminderScheduled) SaveReminderResult.Saved
            else SaveReminderResult.SavedWithoutReminder
        } catch (e: CancellationException) {
            // The user left the screen while saving: it is not an error.
            throw e
        } catch (e: Exception) {
            Log.e(
                CREATE_BIRTHDAY_REPOSITORY_TAG,
                "Error saving birthday reminder: ${e.message}",
                e
            )

            SaveReminderResult.Failed(e)
        }
    }
}