package com.raulcatalinas.cakeday.screens.settings.enums

import androidx.annotation.StringRes
import com.raulcatalinas.cakeday.R

enum class LanguageOptions(@StringRes val labelRes: Int, val code: String) {
    ENGLISH(R.string.english, "en"),
    SPANISH(R.string.spanish, "es"),
    SYSTEM(R.string.system, "sys")
}