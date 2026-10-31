package com.raulcatalinas.cakeday.shared.components

import androidx.compose.foundation.border
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.Person
import androidx.compose.material3.Icon
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.platform.LocalDensity
import androidx.compose.ui.unit.Dp
import androidx.compose.ui.unit.dp

@Composable
fun CircleAvatar(
    nameInitialChar: Char?,
    modifier: Modifier = Modifier,
    size: Dp = 96.dp,
) {
    val color = MaterialTheme.colorScheme.outline

    Box(
        contentAlignment = Alignment.Center,
        modifier =
            modifier
                .size(size)
                .border(2.dp, color, CircleShape)
    ) {
        if (nameInitialChar == null) {
            Icon(
                imageVector = Icons.Default.Person,
                contentDescription = null,
                tint = color,
                modifier = Modifier.size(size * 0.5f)
            )

            return@Box
        }

        val fontSize = with(LocalDensity.current) {
            (size * 0.4f).toSp()
        }

        Text(
            text = nameInitialChar.toString(),
            color = color,
            fontSize = fontSize
        )
    }
}