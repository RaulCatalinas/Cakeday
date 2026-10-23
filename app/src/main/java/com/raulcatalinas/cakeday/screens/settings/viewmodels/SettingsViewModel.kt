package com.raulcatalinas.cakeday.screens.settings.viewmodels

import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.raulcatalinas.cakeday.screens.settings.enums.LanguageOptions
import com.raulcatalinas.cakeday.screens.settings.enums.ThemeOptions
import com.raulcatalinas.cakeday.screens.settings.repositories.SettingsRepository
import dagger.hilt.android.lifecycle.HiltViewModel
import kotlinx.coroutines.flow.SharingStarted
import kotlinx.coroutines.flow.first
import kotlinx.coroutines.flow.stateIn
import kotlinx.coroutines.launch
import kotlinx.coroutines.runBlocking
import kotlinx.datetime.LocalTime
import javax.inject.Inject

@HiltViewModel
class SettingsViewModel @Inject constructor(
    private val settingsRepository: SettingsRepository
) : ViewModel() {

    private val initialSettings = runBlocking {
        settingsRepository.getSettings().first()
    }

    val settings =
        settingsRepository
            .getSettings()
            .stateIn(
                scope = viewModelScope,
                started = SharingStarted.Eagerly,
                initialValue = initialSettings
            )

    fun setTheme(theme: ThemeOptions) {
        viewModelScope.launch {
            settingsRepository.setTheme(theme)
        }
    }

    fun setLanguage(language: LanguageOptions) {
        viewModelScope.launch {
            settingsRepository.setLanguage(language)
        }
    }

    fun setNotificationsEnabled(notificationEnabled: Boolean) {
        viewModelScope.launch {
            settingsRepository.setNotificationsEnabled(notificationEnabled)
        }
    }

    fun setAdvanceNotice(advanceNotice: Boolean) {
        viewModelScope.launch {
            settingsRepository.setAdvanceNotice(advanceNotice)
        }
    }

    fun setNotificationTime(notificationTime: LocalTime) {
        viewModelScope.launch {
            settingsRepository.setNotificationTime(notificationTime)
        }
    }

    fun setGlobalMessage(globalMessage: String) {
        viewModelScope.launch {
            settingsRepository.setGlobalMessage(globalMessage)
        }
    }

    fun getCurrentLanguage() = settingsRepository.getCurrentLanguage()
}