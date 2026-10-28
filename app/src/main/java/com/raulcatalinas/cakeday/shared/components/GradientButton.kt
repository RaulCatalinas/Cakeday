package com.raulcatalinas.cakeday.shared.components

import androidx.compose.foundation.background
import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.Brush
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.semantics.Role
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.unit.Dp
import androidx.compose.ui.unit.dp

@Composable
fun GradientButton(
    modifier: Modifier = Modifier,
    enabled: Boolean = true,
    text: String,
    colors: List<Color>,
    borderRadius: Dp = 25.dp,
    verticalPadding: Dp = 15.dp,
    onClick: () -> Unit,
) {
    Box(
        modifier = modifier
            .fillMaxWidth()
            .clip(
                RoundedCornerShape(
                    borderRadius
                )
            )
            .background(
                Brush.horizontalGradient(
                    if (enabled) colors
                    else colors.map { it.copy(alpha = 0.5f) }
                )
            )
            .clickable(
                role = Role.Button,
                onClick = onClick,
                enabled = enabled
            )
            .padding(vertical = verticalPadding),
        contentAlignment = Alignment.Center
    ) {
        Text(
            text = text,
            color = Color.White,
            style = MaterialTheme.typography.titleMedium,
            fontWeight = FontWeight.Bold
        )
    }
}