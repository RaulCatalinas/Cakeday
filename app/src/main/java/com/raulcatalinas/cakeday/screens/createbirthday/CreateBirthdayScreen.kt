package com.raulcatalinas.cakeday.screens.createbirthday

import android.Manifest
import android.util.Log
import androidx.compose.foundation.background
import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.ColumnScope
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.RowScope
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.heightIn
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.layout.widthIn
import androidx.compose.foundation.rememberScrollState
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.foundation.verticalScroll
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.automirrored.filled.ArrowForwardIos
import androidx.compose.material.icons.filled.Cake
import androidx.compose.material.icons.filled.CardGiftcard
import androidx.compose.material.icons.filled.MarkUnreadChatAlt
import androidx.compose.material.icons.filled.NoteAlt
import androidx.compose.material.icons.filled.Person
import androidx.compose.material3.Button
import androidx.compose.material3.ButtonDefaults
import androidx.compose.material3.Card
import androidx.compose.material3.HorizontalDivider
import androidx.compose.material3.Icon
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Text
import androidx.compose.material3.TextButton
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.alpha
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.vector.ImageVector
import androidx.compose.ui.platform.LocalConfiguration
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.res.stringResource
import androidx.compose.ui.semantics.contentDescription
import androidx.compose.ui.semantics.semantics
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import androidx.core.app.ActivityCompat
import com.raulcatalinas.cakeday.R
import com.raulcatalinas.cakeday.screens.createbirthday.constants.ContactButtonRed
import com.raulcatalinas.cakeday.shared.components.AppCheckbox
import com.raulcatalinas.cakeday.shared.components.AppDatePicker
import com.raulcatalinas.cakeday.shared.components.AppScaffold
import com.raulcatalinas.cakeday.shared.components.AppSwitch
import com.raulcatalinas.cakeday.shared.components.CircleAvatar
import com.raulcatalinas.cakeday.shared.components.GradientButton
import com.raulcatalinas.cakeday.shared.components.Input
import com.raulcatalinas.cakeday.shared.contacts.rememberContactPicker
import com.raulcatalinas.cakeday.shared.extensions.findActivity
import com.raulcatalinas.cakeday.shared.extensions.normalizedInitial
import com.raulcatalinas.cakeday.shared.extensions.openAppSettings
import com.raulcatalinas.cakeday.shared.extensions.verticalScrollbar
import com.raulcatalinas.cakeday.shared.types.ContactInfo
import com.raulcatalinas.cakeday.shared.utils.BirthdayDateFormatter
import com.raulcatalinas.cakeday.shared.utils.LocalSnackbarController
import java.time.LocalDate

private const val TAG = "CreateBirthdayScreen"

private val DateIconColor = Color(0xFFFF9500)
private val YearIconColor = Color(0xFFFF6B6B)

@Composable
fun CreateBirthdayScreen() {
    val context = LocalContext.current
    val snackbar = LocalSnackbarController.current

    val scrollState = rememberScrollState()

    val locale = LocalConfiguration.current.locales[0]

    val dateFormatter = remember(locale) { BirthdayDateFormatter(locale) }

    // null until the user picks a contact, so there is nothing to draw before.
    var contact by remember { mutableStateOf<ContactInfo?>(null) }
    var selectedDate by remember { mutableStateOf<LocalDate?>(null) }
    var includeYear by remember { mutableStateOf(false) }
    var hasPersonalisedMessage by remember { mutableStateOf(false) }
    var personalisedMessage by remember { mutableStateOf<String?>(null) }
    var hasNote by remember { mutableStateOf(false) }
    var note by remember { mutableStateOf<String?>(null) }
    var noteMinimumCharsReached by remember { mutableStateOf(false) }
    var personalisedMessageMinimumCharsReached by remember { mutableStateOf(false) }

    val contactsPermissionDeniedMessage =
        stringResource(R.string.contacts_permission_denied)
    val openSettingsMessage = stringResource(R.string.open_settings)
    val changeContactDescription =
        stringResource(R.string.change_contact_description)
    val chooseContactDescription =
        stringResource(R.string.choose_contact_description)

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
                actionLabel = if (blocked) openSettingsMessage else null,
                onAction = { context.openAppSettings() }
            )
        }
    ) {
        contact = it
    }

    AppScaffold { paddingValues ->
        Column(
            modifier =
                Modifier
                    .padding(paddingValues)
                    .padding(horizontal = 20.dp, vertical = 16.dp)
                    .verticalScrollbar(scrollState)
                    .verticalScroll(scrollState)
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

            // The preview is always on screen so the layout does not jump.
            // Until a contact is picked it shows placeholder texts.
            val picked = contact

            ContactCard {
                CircleAvatar(
                    imageByteArray = picked?.photo,
                    defaultChar = picked?.name?.normalizedInitial,
                    size = 48.dp
                )

                Column(
                    modifier = Modifier.weight(1f),
                    verticalArrangement = Arrangement.spacedBy(4.dp)
                ) {
                    Text(
                        text = picked?.name
                            ?: stringResource(R.string.no_contact_selected),
                        fontSize = 16.sp,
                        color = if (picked == null) {
                            MaterialTheme.colorScheme.onSurfaceVariant
                        } else {
                            Color.Unspecified
                        }
                    )

                    if (picked != null) {
                        Text(
                            text = picked.phone
                                ?: stringResource(R.string.no_phone_number),
                            fontSize = 14.sp,
                            color = MaterialTheme.colorScheme.onSurfaceVariant
                        )
                    }
                }

                TextButton(
                    onClick = pickContact,
                    modifier = Modifier.semantics {
                        contentDescription =
                            if (picked == null) chooseContactDescription
                            else changeContactDescription
                    }
                ) {
                    Text(
                        text = stringResource(
                            if (picked == null) R.string.choose
                            else R.string.change_contact
                        ),
                        color = ContactButtonRed
                    )
                }
            }

            val date = selectedDate

            FormCard {
                AppDatePicker(
                    trigger = { open ->
                        FormRow(
                            icon = Icons.Default.Cake,
                            iconTint = DateIconColor,
                            label = stringResource(R.string.date),
                            onClick = open
                        ) {
                            ValueText(
                                text = if (date != null) {
                                    dateFormatter.format(date, includeYear = false)
                                } else {
                                    stringResource(R.string.choose)
                                },
                                hasValue = date != null,
                                modifier = Modifier.weight(1f)
                            )

                            Icon(
                                imageVector = Icons.AutoMirrored.Filled.ArrowForwardIos,
                                contentDescription = null,
                                tint = MaterialTheme.colorScheme.onSurfaceVariant
                                    .copy(alpha = 0.5f),
                                modifier = Modifier.size(16.dp)
                            )
                        }
                    }
                ) {
                    selectedDate = it
                }

                HorizontalDivider(modifier = Modifier.padding(start = 68.dp, end = 16.dp))

                val yearText = date?.takeIf { includeYear }?.year?.toString()

                FormRow(
                    icon = Icons.Default.CardGiftcard,
                    iconTint = YearIconColor,
                    label = stringResource(R.string.year_of_birth),
                    dimmed = !includeYear
                ) {
                    ValueText(
                        text = yearText ?: stringResource(R.string.hidden_year_text),
                        hasValue = yearText != null,
                        modifier = Modifier.weight(1f)
                    )

                    AppCheckbox {
                        includeYear = it
                    }
                }
            }

            FormCard {
                FormRow(
                    icon = Icons.Default.MarkUnreadChatAlt,
                    iconTint = Color.White,
                    label = stringResource(R.string.personalised_message)
                ) {
                    AppSwitch {
                        hasPersonalisedMessage = it
                    }
                }

                if (!hasPersonalisedMessage) return@FormCard

                FormRow {
                    Input(
                        isOutlined = true,
                        showCharacterCounter = true,
                        minimumCharacterCount = 5,
                        placeholder = stringResource(
                            R.string.personalized_message_input_hint_text
                        ),
                        onTooShort = { personalisedMessageMinimumCharsReached = false },
                        onMinimumReached = { personalisedMessageMinimumCharsReached = true }
                    ) {
                        personalisedMessage = it
                    }
                }
            }

            FormCard {
                FormRow(
                    icon = Icons.Default.NoteAlt,
                    iconTint = Color.White,
                    label = stringResource(R.string.note)
                ) {
                    AppSwitch {
                        hasNote = it
                    }
                }

                if (!hasNote) return@FormCard

                FormRow {
                    Input(
                        isOutlined = true,
                        showCharacterCounter = true,
                        minimumCharacterCount = 5,
                        placeholder = stringResource(
                            R.string.note_input_hint_text
                        ),
                        onTooShort = { noteMinimumCharsReached = false },
                        onMinimumReached = { noteMinimumCharsReached = true }
                    ) {
                        note = it
                    }
                }
            }

            GradientButton(
                enabled =
                    contact != null
                            && selectedDate != null
                            && (!hasPersonalisedMessage || personalisedMessageMinimumCharsReached)
                            && (!hasNote || noteMinimumCharsReached),
                text = stringResource(
                    R.string.btn_save_birthday
                ),
                colors = listOf(
                    Color(0xFFFF6B6B),
                    Color(0xFFFF8E53)
                )
            ) {
                // TODO(placeholder): replace with the real logic
                //  (save to Room and schedule the reminder)
                Log.i(
                    "CreateBirthdayScreen",
                    "Saving birthday reminder..."
                )
            }
        }
    }
}

@Composable
private fun ContactCard(content: @Composable RowScope.() -> Unit) {
    Card(
        modifier =
            Modifier
                .fillMaxWidth()
                .heightIn(min = 56.dp),
        shape = RoundedCornerShape(16.dp),
    ) {
        Row(
            modifier =
                Modifier
                    .fillMaxWidth()
                    .padding(12.dp),
            verticalAlignment = Alignment.CenterVertically,
            horizontalArrangement = Arrangement.spacedBy(12.dp),
            content = content
        )
    }
}

// One card that holds several rows separated by lines.
@Composable
private fun FormCard(content: @Composable ColumnScope.() -> Unit) {
    Card(
        modifier = Modifier.fillMaxWidth(),
        shape = RoundedCornerShape(16.dp),
        content = content
    )
}

@Composable
private fun FormRow(
    icon: ImageVector,
    iconTint: Color,
    label: String,
    modifier: Modifier = Modifier,
    onClick: (() -> Unit)? = null,
    dimmed: Boolean = false,
    content: @Composable RowScope.() -> Unit,
) {
    Row(
        modifier = modifier
            .fillMaxWidth()
            .then(
                if (onClick != null) Modifier.clickable(onClick = onClick)
                else Modifier
            )
            .heightIn(min = 56.dp)
            .padding(horizontal = 16.dp, vertical = 12.dp),
        verticalAlignment = Alignment.CenterVertically,
        horizontalArrangement = Arrangement.spacedBy(12.dp)
    ) {
        Box(
            modifier =
                Modifier
                    .size(40.dp)
                    .alpha(if (dimmed) 0.5f else 1f)
                    .background(iconTint.copy(alpha = 0.15f), RoundedCornerShape(10.dp)),
            contentAlignment = Alignment.Center
        ) {
            Icon(imageVector = icon, contentDescription = null, tint = iconTint)
        }

        // The same minimum width in every row makes the values line up.
        Text(
            text = label,
            color = MaterialTheme.colorScheme.onSurfaceVariant,
            modifier =
                Modifier
                    .widthIn(min = 72.dp)
                    .alpha(if (dimmed) 0.5f else 1f)
        )

        content()
    }
}

@Composable
private fun FormRow(
    modifier: Modifier = Modifier,
    content: @Composable RowScope.() -> Unit,
) {
    Row(
        modifier = modifier
            .fillMaxWidth()
            .heightIn(min = 56.dp)
            .padding(horizontal = 16.dp, vertical = 12.dp),
        verticalAlignment = Alignment.CenterVertically,
        horizontalArrangement = Arrangement.spacedBy(12.dp),
        content = content
    )
}

// Bold when there is a value, gray and regular when it is only a hint.
@Composable
private fun ValueText(
    text: String,
    hasValue: Boolean,
    modifier: Modifier = Modifier,
) {
    Text(
        text = text,
        style = MaterialTheme.typography.titleMedium,
        fontWeight =
            if (hasValue) FontWeight.Bold
            else FontWeight.Normal,
        color =
            if (hasValue) Color.Unspecified
            else MaterialTheme.colorScheme.onSurfaceVariant,
        modifier = modifier
    )
}