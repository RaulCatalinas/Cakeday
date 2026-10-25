package com.raulcatalinas.cakeday.shared.components

import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.Add
import androidx.compose.material3.FloatingActionButton
import androidx.compose.material3.Icon
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.vector.ImageVector

@Composable
fun AppFloatingActionButton(
    modifier: Modifier = Modifier,
    icon: ImageVector = Icons.Default.Add,
    contentDescription: String,
    onClick: () -> Unit
) {
    FloatingActionButton(modifier = modifier, onClick = onClick) {
        Icon(
            imageVector = icon,
            contentDescription = contentDescription
        )
    }
}