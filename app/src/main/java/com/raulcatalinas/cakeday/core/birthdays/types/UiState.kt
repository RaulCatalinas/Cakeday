package com.raulcatalinas.cakeday.core.birthdays.types

import androidx.annotation.StringRes

sealed interface UiState<out T> {
    data object Loading : UiState<Nothing>

    data class Success<T>(
        val data: T
    ) : UiState<T>

    data class Error(
        @StringRes val messageRes: Int
    ) : UiState<Nothing>
}