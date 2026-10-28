package com.raulcatalinas.cakeday.shared.components

import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.padding
import androidx.compose.material3.Checkbox
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.semantics.Role
import androidx.compose.ui.text.style.TextDecoration
import androidx.compose.ui.unit.dp

@Composable
fun AppCheckbox(
    modifier: Modifier = Modifier,
    text: String? = null,
    initialValue: Boolean = false,
    textDecoration: TextDecoration? = null,
    onCheckedChange: (Boolean) -> Unit
) {
    var isChecked by remember { mutableStateOf(initialValue) }

    Row(
        modifier = modifier.clickable(
            role = Role.Checkbox,
            onClick = {
                isChecked = !isChecked
                onCheckedChange(isChecked)
            },
        ),
        verticalAlignment = Alignment.CenterVertically
    ) {
        Checkbox(
            checked = isChecked,
            onCheckedChange = null
        )

        if (text != null) {
            Text(
                text = text,
                textDecoration = textDecoration,
                style = MaterialTheme.typography.bodyLarge,
                modifier = Modifier.padding(start = 16.dp)
            )
        }
    }
}