package com.raulcatalinas.cakeday.shared.components

import androidx.compose.foundation.background
import androidx.compose.foundation.border
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp

@Composable
fun StatusPill(
    text: String,
    modifier: Modifier = Modifier,
    color: Color = MaterialTheme.colorScheme.onSurfaceVariant,
) {
    val shape = RoundedCornerShape(50)

    Text(
        text = text,
        color = color,
        fontSize = 12.sp,
        fontWeight = FontWeight.Bold,
        modifier =
            modifier
                .background(
                    color.copy(alpha = 0.15f),
                    shape
                )
                .border(
                    1.dp,
                    color.copy(alpha = 0.4f),
                    shape
                )
                .padding(
                    horizontal = 10.dp,
                    vertical = 4.dp
                )
    )
}