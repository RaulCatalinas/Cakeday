package com.raulcatalinas.cakeday.shared.utils

import androidx.compose.material3.SnackbarDuration
import androidx.compose.material3.SnackbarHostState
import androidx.compose.material3.SnackbarResult
import androidx.compose.runtime.Composable
import androidx.compose.runtime.remember
import androidx.compose.runtime.rememberCoroutineScope
import androidx.compose.runtime.staticCompositionLocalOf
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.launch

class SnackbarController(
    val hostState: SnackbarHostState,
    private val scope: CoroutineScope
) {
    /**
     * Shows a message, replacing the one on screen. If [actionLabel] is given,
     * the snackbar has a button that runs [onAction] when pressed.
     */
    fun show(
        message: String,
        actionLabel: String? = null,
        onAction: (() -> Unit)? = null
    ) {
        scope.launch {
            hostState.currentSnackbarData?.dismiss()

            val result = hostState.showSnackbar(
                message = message,
                actionLabel = actionLabel,
                duration = SnackbarDuration.Long,
                withDismissAction = true
            )

            if (result == SnackbarResult.ActionPerformed) onAction?.invoke()
        }
    }
}

val LocalSnackbarController = staticCompositionLocalOf<SnackbarController> {
    error("SnackbarController not provided")
}

@Composable
fun rememberSnackbarController(): SnackbarController {
    val scope = rememberCoroutineScope()
    val hostState = remember { SnackbarHostState() }

    return remember(hostState, scope) { SnackbarController(hostState, scope) }
}
