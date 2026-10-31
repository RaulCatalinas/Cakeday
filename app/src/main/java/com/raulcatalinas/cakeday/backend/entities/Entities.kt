package com.raulcatalinas.cakeday.backend.entities

import androidx.room3.ColumnInfo
import androidx.room3.Entity
import androidx.room3.PrimaryKey

@Entity(tableName = "birthdays")
data class BirthdayEntity(
    @PrimaryKey(autoGenerate = true)
    val id: Int = 0,

    val name: String,
    val phone: String,
    val day: Int,
    val month: Int,
    val year: Int,

    @ColumnInfo(name = "personalised_message")
    val personalisedMessage: String? = null,

    val note: String? = null,

    @ColumnInfo(name = "notification_hour")
    val notificationHour: Int = 9,

    @ColumnInfo(name = "notification_minute")
    val notificationMinute: Int = 0,

    @ColumnInfo(name = "notification_scheduled")
    val notificationScheduled: Boolean = false,

    @ColumnInfo(name = "created_at")
    val createdAt: Long = System.currentTimeMillis(),

    @ColumnInfo(name = "updated_at")
    val updatedAt: Long = System.currentTimeMillis()
)