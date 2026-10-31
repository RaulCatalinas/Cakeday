package com.raulcatalinas.cakeday.di

import android.content.Context
import androidx.room3.Room
import androidx.sqlite.driver.AndroidSQLiteDriver
import com.raulcatalinas.cakeday.backend.db.AppDatabase
import dagger.Module
import dagger.Provides
import dagger.hilt.InstallIn
import dagger.hilt.android.qualifiers.ApplicationContext
import dagger.hilt.components.SingletonComponent
import javax.inject.Singleton

@Module
@InstallIn(SingletonComponent::class)
object DatabaseModule {

    @Provides
    @Singleton
    fun provideAppDatabase(
        @ApplicationContext context: Context
    ): AppDatabase {
        return Room
            .databaseBuilder<AppDatabase>(
                context = context,
                name = "cakeday"
            )
            .setDriver(AndroidSQLiteDriver())
            .build()
    }

    @Provides
    fun provideBirthdayDao(db: AppDatabase) = db.birthdayDao()
}
