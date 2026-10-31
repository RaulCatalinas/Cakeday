package com.raulcatalinas.cakeday.backend.db

import androidx.room3.Database
import androidx.room3.RoomDatabase
import com.raulcatalinas.cakeday.backend.daos.BirthdayDao
import com.raulcatalinas.cakeday.backend.entities.BirthdayEntity

@Database(
    version = 1,
    entities = [BirthdayEntity::class],
    exportSchema = false
)
abstract class AppDatabase : RoomDatabase() {
    abstract fun birthdayDao(): BirthdayDao
}