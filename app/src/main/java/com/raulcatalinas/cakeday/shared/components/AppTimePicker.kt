package com.raulcatalinas.cakeday.shared.components

import androidx.compose.material3.AlertDialog
import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.material3.Text
import androidx.compose.material3.TextButton
import androidx.compose.material3.TimePicker
import androidx.compose.material3.rememberTimePickerState
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableIntStateOf
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.saveable.rememberSaveable
import androidx.compose.runtime.setValue
import androidx.compose.ui.res.stringResource
import kotlinx.datetime.LocalTime

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun AppTimePicker(
    initialTime: LocalTime,
    is24Hour: Boolean = true,
    trigger: @Composable (open: () -> Unit) -> Unit,
    onTimeSelected: (LocalTime) -> Unit,
) {
    var hour by rememberSaveable { mutableIntStateOf(initialTime.hour) }
    var minute by rememberSaveable { mutableIntStateOf(initialTime.minute) }
    var showDialog by rememberSaveable { mutableStateOf(false) }

    trigger { showDialog = true }

    if (!showDialog) return

    val state = rememberTimePickerState(
        initialHour = hour,
        initialMinute = minute,
        is24Hour = is24Hour
    )

    AlertDialog(
        onDismissRequest = { showDialog = false },
        confirmButton = {
            TextButton(
                onClick = {
                    hour = state.hour
                    minute = state.minute
                    showDialog = false
                    onTimeSelected(LocalTime(hour, minute, 0))
                }
            ) { Text(stringResource(android.R.string.ok)) }
        },
        dismissButton = {
            TextButton(onClick = { showDialog = false }) {
                Text(stringResource(android.R.string.cancel))
            }
        },
        text = { TimePicker(state = state) }
    )
}