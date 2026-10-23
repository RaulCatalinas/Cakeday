package com.raulcatalinas.cakeday.shared.components

import androidx.compose.material3.Switch
import androidx.compose.material3.SwitchDefaults
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.rememberCoroutineScope
import androidx.compose.runtime.saveable.rememberSaveable
import androidx.compose.runtime.setValue
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import kotlinx.coroutines.launch

@Composable
fun AppSwitch(
    modifier: Modifier = Modifier,
    activatedColor: Color = Color(0xFF34C759),
    initialValue: Boolean = false,
    preOnChanged: (suspend () -> Boolean)? = null,
    onChanged: (Boolean) -> Unit,
) {
    var activated by rememberSaveable { mutableStateOf(initialValue) }
    val scope = rememberCoroutineScope()

    Switch(
        checked = activated,
        onCheckedChange = { value ->
            scope.launch {
                if (preOnChanged?.invoke() == false) return@launch

                activated = value
                onChanged(value)
            }
        },
        modifier = modifier,
        colors = SwitchDefaults.colors(
            checkedTrackColor = activatedColor,
            checkedThumbColor = Color.White
        )
    )
}