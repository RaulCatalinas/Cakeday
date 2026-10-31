package com.raulcatalinas.cakeday.core.birthdays.types

import androidx.annotation.StringRes

// Result of a one-off action: either the data or the text to show to the user.
sealed interface UiResult<out T> {
    data class Success<T>(
        val data: T
    ) : UiResult<T>

    data class Error(
        @StringRes val messageRes: Int
    ) : UiResult<Nothing>
}