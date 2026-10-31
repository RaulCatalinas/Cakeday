package com.raulcatalinas.cakeday.core.birthdays.repositories

import com.raulcatalinas.cakeday.backend.repotories.DbRepository
import com.raulcatalinas.cakeday.shared.models.BirthdayModel
import com.raulcatalinas.cakeday.shared.types.ContactInfo
import kotlinx.datetime.LocalTime
import java.time.LocalDate
import javax.inject.Inject

class BirthdayRepository @Inject constructor(
    private val dbRepository: DbRepository
) {
    suspend fun deleteBirthday(id: Int): Int {
        return dbRepository.deleteBirthday(id)
    }

    suspend fun createBirthday(
        birthday: LocalDate,
        contactInfo: ContactInfo,
        notificationTime: LocalTime,
        personalisedMessage: String?,
        note: String?
    ): Long {
        val birthdayModel = BirthdayModel(
            contactInfo = contactInfo,
            birthday = birthday,
            notificationHour = notificationTime.hour,
            notificationMinute = notificationTime.minute,
            note = note,
            personalisedMessage = personalisedMessage
        )

        return dbRepository.createBirthday(birthdayModel)
    }

    suspend fun getBirthdayById(id: Int): BirthdayModel? {
        return dbRepository.getBirthdayById(id)
    }

    suspend fun getAllBirthdays(): List<BirthdayModel> {
        return dbRepository.getAllBirthdays()
    }

    suspend fun existsBirthday(
        name: String,
        phone: String,
        day: Int,
        month: Int
    ): Boolean {
        return dbRepository.existsBirthday(
            name = name,
            phone = phone,
            day = day,
            month = month
        )
    }

    suspend fun getIdByInfo(
        name: String,
        phone: String,
        day: Int,
        month: Int
    ): Int? {
        return dbRepository.getIdByInfo(
            name = name,
            phone = phone,
            day = day,
            month = month
        )
    }

    suspend fun updateNotificationScheduled(
        id: Int,
        scheduled: Boolean
    ): Int {
        return dbRepository.updateNotificationScheduled(
            id = id,
            scheduled = scheduled
        )
    }

    suspend fun updateBirthday(
        id: Int,
        day: Int,
        month: Int,
        year: Int?,
        personalisedMessage: String?,
        note: String?
    ): Int {
        return dbRepository.updateBirthday(
            id = id,
            day = day,
            month = month,
            year = year,
            personalisedMessage = personalisedMessage,
            note = note
        )
    }
}