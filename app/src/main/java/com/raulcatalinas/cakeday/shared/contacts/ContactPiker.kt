package com.raulcatalinas.cakeday.shared.contacts

import android.Manifest
import android.app.Activity
import android.content.Context
import android.content.Intent
import android.net.Uri
import android.provider.ContactsContract.CommonDataKinds.Phone
import android.util.Log
import androidx.activity.compose.rememberLauncherForActivityResult
import androidx.activity.result.contract.ActivityResultContract
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.runtime.remember
import androidx.compose.runtime.rememberCoroutineScope
import androidx.compose.runtime.rememberUpdatedState
import androidx.compose.ui.platform.LocalContext
import com.raulcatalinas.cakeday.shared.permissions.rememberPermissionRequester
import com.raulcatalinas.cakeday.shared.types.ContactInfo
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import kotlinx.coroutines.withContext

// Opens the system contact list showing one row per phone number.
private class PickPhoneContract : ActivityResultContract<Unit, Uri?>() {
    override fun createIntent(context: Context, input: Unit): Intent =
        Intent(Intent.ACTION_PICK, Phone.CONTENT_URI)

    override fun parseResult(resultCode: Int, intent: Intent?): Uri? =
        intent?.data?.takeIf { resultCode == Activity.RESULT_OK }
}

/**
 * Returns a function that opens the contact picker. It asks for READ_CONTACTS
 * first and, if the user denies it, the picker is not opened and
 * [onPermissionDenied] is called. [onContactPicked] receives the data copied.
 */
@Composable
fun rememberContactPicker(
    // TODO: replace the log with a Snackbar
    onPermissionDenied: () -> Unit,
    onContactPicked: (ContactInfo) -> Unit,
): () -> Unit {
    val context = LocalContext.current
    val scope = rememberCoroutineScope()
    val currentOnContactPicked by rememberUpdatedState(onContactPicked)
    val currentOnPermissionDenied by rememberUpdatedState(onPermissionDenied)
    val requestContactsPermission =
        rememberPermissionRequester(Manifest.permission.READ_CONTACTS)

    val launcher = rememberLauncherForActivityResult(PickPhoneContract()) { uri ->
        if (uri == null) return@rememberLauncherForActivityResult

        scope.launch {
            readContact(context, uri)?.let(currentOnContactPicked)
        }
    }

    return remember(launcher, requestContactsPermission) {
        val open: () -> Unit = {
            scope.launch {
                if (requestContactsPermission()) {
                    launcher.launch(Unit)
                } else {
                    currentOnPermissionDenied()
                }
            }
        }

        open
    }
}

private suspend fun readContact(context: Context, uri: Uri): ContactInfo? =
    withContext(Dispatchers.IO) {
        val resolver = context.contentResolver
        val projection = arrayOf(Phone.DISPLAY_NAME, Phone.NUMBER, Phone.PHOTO_URI)

        runCatching {
            resolver
                .query(
                    uri,
                    projection,
                    null,
                    null,
                    null
                )
                ?.use { cursor ->
                    if (!cursor.moveToFirst()) return@use null

                    val name = cursor.getString(0) ?: return@use null
                    val phone = cursor.getString(1)

                    ContactInfo(name = name, phone = phone)
                }
        }
            .onFailure {
                Log.e(
                    "ContactPicker",
                    "Couldn't read the picked contact",
                    it
                )
            }
            .getOrNull()
    }