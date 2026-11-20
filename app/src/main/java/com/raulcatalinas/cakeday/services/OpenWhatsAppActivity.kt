package com.raulcatalinas.cakeday.services

import android.content.ActivityNotFoundException
import android.content.Intent
import android.net.Uri
import android.os.Bundle
import android.util.Log
import androidx.activity.compose.setContent
import androidx.appcompat.app.AppCompatActivity
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.material3.SnackbarDuration
import androidx.compose.material3.SnackbarHost
import androidx.compose.material3.SnackbarHostState
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.runtime.remember
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import com.raulcatalinas.cakeday.R
import com.raulcatalinas.cakeday.services.constants.EXTRA_MESSAGE
import com.raulcatalinas.cakeday.services.constants.EXTRA_NAME
import com.raulcatalinas.cakeday.services.constants.EXTRA_PHONE
import com.raulcatalinas.cakeday.services.constants.NAME_PLACEHOLDER
import com.raulcatalinas.cakeday.services.constants.OPEN_WHATSAPP_ACTIVITY_TAG
import com.raulcatalinas.cakeday.services.constants.WHATSAPP_AUTHORITY
import com.raulcatalinas.cakeday.services.constants.WHATSAPP_PHONE_QUERY_PARAM
import com.raulcatalinas.cakeday.services.constants.WHATSAPP_SCHEME
import com.raulcatalinas.cakeday.services.constants.WHATSAPP_TEXT_QUERY_PARAM
import com.raulcatalinas.cakeday.services.constants.phoneRegex

class OpenWhatsAppActivity : AppCompatActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        val phone =
            intent
                .getStringExtra(EXTRA_PHONE)
                .orEmpty()
        val message =
            intent
                .getStringExtra(EXTRA_MESSAGE)
                .orEmpty()
        val name =
            intent
                .getStringExtra(EXTRA_NAME)
                .orEmpty()

        val whatsappIntent = Intent(
            Intent.ACTION_VIEW,
            createWhatsAppUri(
                phone = phone,
                message = message,
                name = name
            )
        )

        try {
            startActivity(whatsappIntent)
            finish()
        } catch (e: ActivityNotFoundException) {
            Log.e(
                OPEN_WHATSAPP_ACTIVITY_TAG,
                "WhatsApp not installed",
                e
            )

            showErrorSnackbar()
        }
    }

    private fun createWhatsAppUri(
        phone: String,
        message: String,
        name: String
    ): Uri {
        val cleanPhone =
            phone
                .trim()
                .replace(
                    phoneRegex,
                    ""
                )

        val finalMessage =
            message
                .trim()
                .replace(
                    NAME_PLACEHOLDER,
                    name
                )

        return Uri
            .Builder()
            .scheme(WHATSAPP_SCHEME)
            .authority(WHATSAPP_AUTHORITY)
            .appendQueryParameter(
                WHATSAPP_PHONE_QUERY_PARAM,
                cleanPhone
            )
            .appendQueryParameter(
                WHATSAPP_TEXT_QUERY_PARAM,
                finalMessage
            )
            .build()
    }

    private fun showErrorSnackbar() {
        setContent {
            val snackbarHostState = remember { SnackbarHostState() }

            LaunchedEffect(Unit) {
                snackbarHostState.showSnackbar(
                    message = getString(
                        R.string.whatsapp_unavailable
                    ),
                    duration = SnackbarDuration.Short
                )

                finish()
            }

            Box(
                modifier = Modifier.fillMaxSize(),
                contentAlignment = Alignment.BottomCenter
            ) {
                SnackbarHost(hostState = snackbarHostState)
            }
        }
    }

}