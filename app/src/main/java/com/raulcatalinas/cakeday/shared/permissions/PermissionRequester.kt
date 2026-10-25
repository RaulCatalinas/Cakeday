package com.raulcatalinas.cakeday.shared.permissions

import android.Manifest
import android.annotation.SuppressLint
import android.content.pm.PackageManager
import android.os.Build
import androidx.activity.compose.rememberLauncherForActivityResult
import androidx.activity.result.contract.ActivityResultContracts
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.setValue
import androidx.compose.ui.platform.LocalContext
import androidx.core.app.NotificationManagerCompat
import androidx.core.content.ContextCompat
import kotlinx.coroutines.CompletableDeferred

/**
 * Returns a function that asks for [permission] and waits for the answer.
 * It returns true right away if the permission was already granted.
 */
@Composable
fun rememberPermissionRequester(permission: String): suspend () -> Boolean {
    val context = LocalContext.current
    var pending by remember { mutableStateOf<CompletableDeferred<Boolean>?>(null) }

    val launcher = rememberLauncherForActivityResult(
        ActivityResultContracts.RequestPermission()
    ) { granted ->
        pending?.complete(granted)
        pending = null
    }

    return remember(context, permission, launcher) {
        val request: suspend () -> Boolean = {
            val alreadyGranted =
                ContextCompat.checkSelfPermission(context, permission) ==
                        PackageManager.PERMISSION_GRANTED

            if (alreadyGranted) {
                true
            } else {
                val result = CompletableDeferred<Boolean>().also { pending = it }

                launcher.launch(permission)
                result.await()
            }
        }

        request
    }
}

/**
 * Same idea for notifications, valid on every Android version:
 * asks for POST_NOTIFICATIONS on Android 13+ and, in any case, checks that
 * notifications are really enabled for the app.
 */
@SuppressLint("InlinedApi")
@Composable
fun rememberNotificationPermissionRequester(): suspend () -> Boolean {
    val context = LocalContext.current
    val requestPostNotifications =
        rememberPermissionRequester(Manifest.permission.POST_NOTIFICATIONS)

    return remember(context, requestPostNotifications) {
        val request: suspend () -> Boolean = {
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
                requestPostNotifications()
            }

            NotificationManagerCompat.from(context).areNotificationsEnabled()
        }

        request
    }
}
