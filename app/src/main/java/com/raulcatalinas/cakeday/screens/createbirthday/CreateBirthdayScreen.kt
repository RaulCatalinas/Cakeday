package com.raulcatalinas.cakeday.screens.createbirthday

import android.Manifest
import android.util.Log
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.heightIn
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.automirrored.filled.ArrowForwardIos
import androidx.compose.material.icons.filled.Person
import androidx.compose.material3.Button
import androidx.compose.material3.ButtonDefaults
import androidx.compose.material3.Icon
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.res.stringResource
import androidx.compose.ui.unit.dp
import androidx.core.app.ActivityCompat
import com.raulcatalinas.cakeday.R
import com.raulcatalinas.cakeday.screens.createbirthday.constants.ContactButtonRed
import com.raulcatalinas.cakeday.shared.components.AppScaffold
import com.raulcatalinas.cakeday.shared.contacts.rememberContactPicker
import com.raulcatalinas.cakeday.shared.extensions.findActivity
import com.raulcatalinas.cakeday.shared.extensions.openAppSettings
import com.raulcatalinas.cakeday.shared.utils.LocalSnackbarController

private const val TAG = "CreateBirthdayScreen"

@Composable
fun CreateBirthdayScreen() {
    val context = LocalContext.current
    val snackbar = LocalSnackbarController.current

    val contactsPermissionDeniedMessage =
        stringResource(
            R.string.contacts_permission_denied
        )
    val openSettingsMessage =
        stringResource(
            R.string.open_settings
        )

    val pickContact = rememberContactPicker(
        onPermissionDenied = {
            Log.w(TAG, "READ_CONTACTS denied: contact not read")

            // Asked and denied, yet no reason to ask again means that Android
            // will not show the dialog anymore: only the settings can fix it.
            val blocked = context.findActivity()?.let {
                !ActivityCompat.shouldShowRequestPermissionRationale(
                    it,
                    Manifest.permission.READ_CONTACTS
                )
            } ?: true

            snackbar.show(
                message = contactsPermissionDeniedMessage,
                actionLabel =
                    if (blocked) openSettingsMessage
                    else null,
                onAction = { context.openAppSettings() }
            )
        }
    ) {
        Log.i(
            TAG,
            "Contact name: ${it.name}, " +
                    "Contact phone: ${it.phone} " +
                    "Contact photo: ${it.photo != null}"
        )
    }

    AppScaffold { paddingValues ->
        Column(
            modifier =
                Modifier
                    .padding(paddingValues)
                    .padding(horizontal = 20.dp, vertical = 16.dp)
                    .fillMaxSize(),
            horizontalAlignment = Alignment.CenterHorizontally,
            verticalArrangement = Arrangement.spacedBy(16.dp),
        ) {
            Button(
                onClick = pickContact,
                modifier =
                    Modifier
                        .fillMaxWidth()
                        .heightIn(min = 56.dp),
                shape = RoundedCornerShape(16.dp),
                colors = ButtonDefaults.buttonColors(
                    containerColor = ContactButtonRed.copy(alpha = 0.12f),
                    contentColor = ContactButtonRed
                )
            ) {
                Row(
                    modifier = Modifier.fillMaxWidth(),
                    verticalAlignment = Alignment.CenterVertically,
                    horizontalArrangement = Arrangement.spacedBy(12.dp)
                ) {
                    Icon(
                        imageVector = Icons.Default.Person,
                        contentDescription = null,
                        tint = MaterialTheme.colorScheme.primary
                    )

                    Text(
                        text = stringResource(R.string.pick_contact),
                        style = MaterialTheme.typography.titleMedium,
                        modifier = Modifier.weight(1f)
                    )

                    Icon(
                        imageVector = Icons.AutoMirrored.Filled.ArrowForwardIos,
                        contentDescription = null,
                        modifier = Modifier.size(16.dp)
                    )
                }
            }
        }
    }
}