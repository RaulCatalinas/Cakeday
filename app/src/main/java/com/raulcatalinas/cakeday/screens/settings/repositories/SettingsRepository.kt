package com.raulcatalinas.cakeday.screens.settings.repositories

import androidx.appcompat.app.AppCompatDelegate
import androidx.core.os.LocaleListCompat
import androidx.datastore.core.DataStore
import androidx.datastore.preferences.core.Preferences
import androidx.datastore.preferences.core.booleanPreferencesKey
import androidx.datastore.preferences.core.edit
import androidx.datastore.preferences.core.intPreferencesKey
import androidx.datastore.preferences.core.stringPreferencesKey
import com.raulcatalinas.cakeday.screens.settings.constants.ADVANCE_NOTICE_OPTION_KEY
import com.raulcatalinas.cakeday.screens.settings.constants.DEFAULT_GLOBAL_MESSAGE_OPTION_KEY
import com.raulcatalinas.cakeday.screens.settings.constants.NOTIFICATIONS_ENABLED_OPTION_KEY
import com.raulcatalinas.cakeday.screens.settings.constants.NOTIFICATION_TIME_OPTION_KEY
import com.raulcatalinas.cakeday.screens.settings.constants.THEME_OPTION_KEY
import com.raulcatalinas.cakeday.screens.settings.enums.LanguageOptions
import com.raulcatalinas.cakeday.screens.settings.enums.ThemeOptions
import com.raulcatalinas.cakeday.screens.settings.types.AppSettings
import kotlinx.coroutines.flow.map
import kotlinx.datetime.LocalTime
import javax.inject.Inject

class SettingsRepository @Inject constructor(
    private val dataStore: DataStore<Preferences>
) {
    private object Keys {
        val THEME = stringPreferencesKey(
            THEME_OPTION_KEY
        )
        val NOTIFICATIONS_ENABLED = booleanPreferencesKey(
            NOTIFICATIONS_ENABLED_OPTION_KEY
        )
        val NOTIFICATION_TIME = intPreferencesKey(
            NOTIFICATION_TIME_OPTION_KEY
        )
        val ADVANCE_NOTICE = booleanPreferencesKey(
            ADVANCE_NOTICE_OPTION_KEY
        )
        val DEFAULT_GLOBAL_MESSAGE = stringPreferencesKey(
            DEFAULT_GLOBAL_MESSAGE_OPTION_KEY
        )
    }

    private val settingsFlow = dataStore.data.map { preferences ->
        AppSettings(
            theme =
                preferences[Keys.THEME]
                    ?.let { value ->
                        runCatching { ThemeOptions.valueOf(value) }.getOrNull()
                    }
                    ?: ThemeOptions.System,
            notificationsEnabled = preferences[Keys.NOTIFICATIONS_ENABLED] ?: false,
            advanceNotice = preferences[Keys.ADVANCE_NOTICE] ?: false,
            notificationTime =
                preferences[Keys.NOTIFICATION_TIME]
                    ?.takeIf { it in 0..86399 }
                    ?.let { LocalTime.fromSecondOfDay(it) }
                    ?: LocalTime(9, 0, 0),
            globalMessage = preferences[Keys.DEFAULT_GLOBAL_MESSAGE]
        )
    }

    fun getSettings() = settingsFlow

    suspend fun setTheme(theme: ThemeOptions) {
        dataStore.edit { preferences ->
            preferences[Keys.THEME] = theme.name
        }
    }

    suspend fun setNotificationsEnabled(notificationEnabled: Boolean) {
        dataStore.edit { preferences ->
            preferences[Keys.NOTIFICATIONS_ENABLED] = notificationEnabled
        }
    }

    suspend fun setAdvanceNotice(advanceNotice: Boolean) {
        dataStore.edit { preferences ->
            preferences[Keys.ADVANCE_NOTICE] = advanceNotice
        }
    }

    suspend fun setNotificationTime(notificationTime: LocalTime) {
        dataStore.edit { preferences ->
            preferences[Keys.NOTIFICATION_TIME] = notificationTime.toSecondOfDay()
        }
    }

    suspend fun setGlobalMessage(globalMessage: String) {
        dataStore.edit { preferences ->
            preferences[Keys.DEFAULT_GLOBAL_MESSAGE] = globalMessage
        }
    }

    fun setLanguage(language: LanguageOptions) {
        val locales = if (language == LanguageOptions.SYSTEM) {
            LocaleListCompat.getEmptyLocaleList()
        } else {
            LocaleListCompat.forLanguageTags(language.code)
        }

        AppCompatDelegate.setApplicationLocales(locales)
    }

    // Reads the language that is really applied, even if the user changed it
    // from the system settings (Android 13+)
    fun getCurrentLanguage(): LanguageOptions {
        val locales = AppCompatDelegate.getApplicationLocales()

        if (locales.isEmpty) return LanguageOptions.SYSTEM

        val language = locales[0]?.language

        return LanguageOptions
            .entries
            .firstOrNull { it.code == language }
            ?: LanguageOptions.SYSTEM
    }
}