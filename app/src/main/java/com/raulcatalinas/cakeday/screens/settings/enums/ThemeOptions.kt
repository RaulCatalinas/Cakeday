package com.raulcatalinas.cakeday.screens.settings.enums

import androidx.annotation.StringRes
import com.raulcatalinas.cakeday.R

enum class ThemeOptions(@StringRes val labelRes: Int) {
    Light(R.string.light_theme),
    Dark(R.string.dark_theme),
    System(R.string.system)
}