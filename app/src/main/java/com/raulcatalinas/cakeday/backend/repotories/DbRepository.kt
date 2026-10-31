package com.raulcatalinas.cakeday.backend.repotories

import com.raulcatalinas.cakeday.backend.db.AppDatabase
import com.raulcatalinas.cakeday.backend.mappers.toDomain
import com.raulcatalinas.cakeday.backend.mappers.toEntity
import com.raulcatalinas.cakeday.shared.models.BirthdayModel
import javax.inject.Inject

class DbRepository @Inject constructor(db: AppDatabase) {
    private val dao = db.birthdayDao()

    suspend fun deleteBirthday(id: Int): Int {
        return dao.deleteBirthday(id)
    }

    suspend fun createBirthday(birthday: BirthdayModel): Long {
        return dao
            .createBirthday(
                birthday.toEntity()
            )
    }

    suspend fun getBirthdayById(id: Int): BirthdayModel? {
        return dao
            .getById(id)
            ?.toDomain()
    }

    suspend fun getAllBirthdays(): List<BirthdayModel> {
        return dao
            .getAllBirthdays()
            .map { it.toDomain() }
    }

    suspend fun existsBirthday(
        name: String,
        phone: String,
        day: Int,
        month: Int
    ): Boolean {
        return dao.existsBirthday(
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
        return dao.getIdByInfo(
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
        return dao.updateNotificationScheduled(
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
        return dao.updateBirthday(
            id = id,
            day = day,
            month = month,
            year = year,
            personalisedMessage = personalisedMessage,
            note = note,
            updatedAt = System.currentTimeMillis()
        )
    }
}