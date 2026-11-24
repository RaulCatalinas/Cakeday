package com.raulcatalinas.cakeday.shared.components

import androidx.compose.foundation.background
import androidx.compose.foundation.combinedClickable
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.RowScope
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.heightIn
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.Card
import androidx.compose.material3.CardDefaults
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Brush
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.unit.dp


@Composable
fun ContactCard(
    modifier: Modifier = Modifier,
    gradientEnabled: Boolean = false,
    onClick: () -> Unit = {},
    onLongClick: () -> Unit = {},
    content: @Composable RowScope.() -> Unit
) {
    val shape = RoundedCornerShape(16.dp)

    val gradient = Brush.horizontalGradient(
        colors = listOf(
            Color(0xFFFF6B6B),
            Color(0xFFFF8A4C)
        )
    )

    Card(
        modifier = modifier
            .fillMaxWidth()
            .heightIn(min = 56.dp)
            .combinedClickable(
                onClick = onClick,
                onLongClick = onLongClick
            ),
        shape = shape,
        colors = CardDefaults.cardColors(
            containerColor = if (gradientEnabled) {
                Color.Transparent
            } else {
                CardDefaults.cardColors().containerColor
            }
        )
    ) {
        Box(
            modifier = Modifier
                .fillMaxWidth()
                .then(
                    if (gradientEnabled) {
                        Modifier.background(gradient, shape)
                    } else {
                        Modifier
                    }
                )
                .padding(12.dp)
        ) {
            Row(
                verticalAlignment = Alignment.CenterVertically,
                horizontalArrangement = Arrangement.spacedBy(12.dp),
                content = content
            )
        }
    }
}
