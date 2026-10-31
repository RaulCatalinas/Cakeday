package com.raulcatalinas.cakeday.backend.daos

import androidx.room3.Dao
import androidx.room3.Insert
import androidx.room3.OnConflictStrategy
import androidx.room3.Query
import com.raulcatalinas.cakeday.backend.entities.BirthdayEntity

@Dao
interface BirthdayDao {
    @Query("DELETE FROM birthdays WHERE id = :id")
    suspend fun deleteBirthday(id: Int): Int

    @Query(
        """
        SELECT EXISTS(
            SELECT 1
            FROM birthdays
            WHERE name = :name
                AND phone = :phone
                AND day = :day
                AND month = :month
        )
        """
    )
    suspend fun existsBirthday(
        name: String,
        phone: String,
        day: Int,
        month: Int
    ): Boolean

    @Query(
        """
        SELECT * FROM birthdays
        ORDER BY month ASC, day ASC, name ASC
        """
    )
    suspend fun getAllBirthdays(): List<BirthdayEntity>

    @Query("SELECT * FROM birthdays WHERE id = :id LIMIT 1")
    suspend fun getById(id: Int): BirthdayEntity?

    @Query(
        """
        SELECT id
        FROM birthdays
        WHERE name = :name
            AND phone = :phone
            AND day = :day
            AND month = :month
        LIMIT 1
        """
    )
    suspend fun getIdByInfo(
        name: String,
        phone: String,
        day: Int,
        month: Int
    ): Int?

    @Insert(onConflict = OnConflictStrategy.ABORT)
    suspend fun createBirthday(birthday: BirthdayEntity): Long

    @Query(
        """
        UPDATE birthdays
        SET notification_scheduled = :scheduled
        WHERE id = :id
        """
    )
    suspend fun updateNotificationScheduled(
        id: Int,
        scheduled: Boolean
    ): Int

    @Query(
        """
    UPDATE birthdays
    SET day = :day,
        month = :month,
        year = :year,
        personalised_message = :personalisedMessage,
        note = :note,
        updated_at = :updatedAt
    WHERE id = :id
    """
    )
    suspend fun updateBirthday(
        id: Int,
        day: Int,
        month: Int,
        year: Int?,
        personalisedMessage: String?,
        note: String?,
        updatedAt: Long = System.currentTimeMillis()
    ): Int
}