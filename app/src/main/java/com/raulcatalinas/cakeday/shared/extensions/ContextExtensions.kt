package com.raulcatalinas.cakeday.shared.extensions

import android.app.Activity
import android.content.Context
import android.content.ContextWrapper
import android.content.Intent
import android.net.Uri
import android.provider.Settings

// Opens the system settings page of this app (permissions, notifications...).
fun Context.openAppSettings() {
    startActivity(
        Intent(
            Settings.ACTION_APPLICATION_DETAILS_SETTINGS,
            Uri.fromParts("package", packageName, null)
        )
    )
}

// The Activity behind a Context, which may be wrapped by other contexts.
fun Context.findActivity(): Activity? {
    var current = this

    while (current is ContextWrapper) {
        if (current is Activity) return current

        current = current.baseContext
    }

    return null
}