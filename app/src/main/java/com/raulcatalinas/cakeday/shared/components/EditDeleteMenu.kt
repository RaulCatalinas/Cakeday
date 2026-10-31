package com.raulcatalinas.cakeday.shared.components

import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.Delete
import androidx.compose.material.icons.filled.Edit
import androidx.compose.material3.DropdownMenu
import androidx.compose.material3.DropdownMenuItem
import androidx.compose.material3.Icon
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.saveable.rememberSaveable
import androidx.compose.runtime.setValue
import androidx.compose.ui.res.stringResource
import com.raulcatalinas.cakeday.R

@Composable
fun EditDeleteMenu(
    onEdit: () -> Unit,
    onDelete: () -> Unit,
    trigger: @Composable (open: () -> Unit) -> Unit,
    editText: String = stringResource(R.string.edit_btn),
) {
    var expanded by rememberSaveable { mutableStateOf(false) }

    trigger { expanded = true }

    DropdownMenu(
        expanded = expanded,
        onDismissRequest = { expanded = false }
    ) {
        DropdownMenuItem(
            text = { Text(editText) },
            leadingIcon = {
                Icon(
                    Icons.Default.Edit,
                    contentDescription = null
                )
            },
            onClick = {
                expanded = false

                onEdit()
            }
        )

        DropdownMenuItem(
            text = {
                Text(
                    stringResource(
                        R.string.delete_btn
                    )
                )
            },
            leadingIcon = {
                Icon(
                    Icons.Default.Delete,
                    contentDescription = null
                )
            },
            onClick = {
                expanded = false

                onDelete()
            }
        )
    }
}