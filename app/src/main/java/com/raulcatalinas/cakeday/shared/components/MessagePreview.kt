package com.raulcatalinas.cakeday.shared.components

import androidx.compose.foundation.background
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.foundation.text.input.TextFieldLineLimits
import androidx.compose.material3.Text
import androidx.compose.material3.TextButton
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.saveable.rememberSaveable
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Brush
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.hapticfeedback.HapticFeedbackType
import androidx.compose.ui.platform.LocalHapticFeedback
import androidx.compose.ui.res.stringResource
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import com.raulcatalinas.cakeday.R

@Composable
fun MessagePreview(
    modifier: Modifier = Modifier,
    initialMessage: String,
    onSave: (String) -> Unit,
) {
    val haptics = LocalHapticFeedback.current

    var message by remember(initialMessage) { mutableStateOf(initialMessage) }
    var editing by rememberSaveable { mutableStateOf(false) }
    var draft by rememberSaveable { mutableStateOf("") }

    var birthdayMinimumCharsReached by remember { mutableStateOf(false) }

    Column(
        modifier = modifier.fillMaxWidth(),
        verticalArrangement = Arrangement.spacedBy(8.dp)
    ) {
        Text(
            text = stringResource(R.string.preview_whatsapp_text),
            fontSize = 12.sp,
            fontWeight = FontWeight.ExtraBold,
            letterSpacing = 1.sp
        )

        Box(
            modifier = Modifier
                .fillMaxWidth()
                .background(
                    brush = Brush.linearGradient(
                        listOf(Color(0xFFFF6B6B), Color(0xFFFF8E53))
                    ),
                    shape = RoundedCornerShape(16.dp)
                )
                .padding(16.dp)
        ) {
            Text(text = message, color = Color.White, fontSize = 13.sp)
        }

        if (!editing) {
            TextButton(
                modifier = Modifier.align(Alignment.End),
                onClick = {
                    draft = message
                    editing = true
                    haptics.performHapticFeedback(HapticFeedbackType.TextHandleMove)
                }
            ) {
                Text(
                    text = "✏️ ${stringResource(R.string.edit_message_button_text)}",
                    fontWeight = FontWeight.Bold
                )
            }

            return@Column
        }

        Input(
            isOutlined = true,
            placeholder = stringResource(R.string.global_birthday_input_hint_text),
            lineLimits = TextFieldLineLimits.MultiLine(maxHeightInLines = 3),
            showCharacterCounter = true,
            minimumCharacterCount = 5,
            initialValue = message,
            onTooShort = { birthdayMinimumCharsReached = false },
            onMinimumReached = { birthdayMinimumCharsReached = true }
        ) {
            draft = it
        }

        Subtitle("💡 {name} ${stringResource(R.string.name_placeholder_info)}")

        Row(
            modifier = Modifier.fillMaxWidth(),
            horizontalArrangement = Arrangement.End
        ) {
            TextButton(onClick = { editing = false }) {
                Text(
                    text = stringResource(android.R.string.cancel),
                    fontWeight = FontWeight.Bold
                )
            }

            TextButton(
                enabled = birthdayMinimumCharsReached,
                onClick = {
                    message = draft
                    editing = false
                    haptics.performHapticFeedback(HapticFeedbackType.LongPress)
                    onSave(draft)
                }
            ) {
                Text(
                    text = "💾 ${stringResource(R.string.save_button_text)}",
                    fontWeight = FontWeight.Bold
                )
            }
        }
    }
}