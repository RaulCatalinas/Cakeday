package com.raulcatalinas.cakeday.shared.components

import android.graphics.BitmapFactory
import androidx.compose.foundation.Image
import androidx.compose.foundation.border
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.runtime.produceState
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.ImageBitmap
import androidx.compose.ui.graphics.asImageBitmap
import androidx.compose.ui.layout.ContentScale
import androidx.compose.ui.platform.LocalDensity
import androidx.compose.ui.unit.Dp
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.withContext

@Composable
fun CircleAvatar(
    imageByteArray: ByteArray?,
    defaultChar: Char,
    modifier: Modifier = Modifier,
    size: Dp = 96.dp,
) {
    val sizePx = with(LocalDensity.current) { size.roundToPx() }

    // Decoded off the main thread and scaled down to the size it is drawn at.
    // While it loads (or if the bytes are not a valid image) the letter is shown.
    val bitmap by produceState<ImageBitmap?>(
        initialValue = null,
        imageByteArray,
        sizePx
    ) {
        value = imageByteArray?.let {
            withContext(Dispatchers.Default) { it.decodeAvatar(sizePx) }
        }
    }

    val color = MaterialTheme.colorScheme.outline

    val circle =
        modifier
            .size(size)
            .clip(CircleShape)
            .border(
                2.dp,
                color,
                CircleShape
            )

    val image = bitmap

    if (image == null) {
        Box(contentAlignment = Alignment.Center, modifier = circle) {
            Text(
                text = defaultChar.toString(),
                color = color,
                fontSize = (size.value * 0.4f).sp
            )
        }

        return
    }

    Image(
        bitmap = image,
        contentDescription = null,
        contentScale = ContentScale.Crop,
        modifier = circle
    )
}

// Reads only the image size first, then decodes at the smallest power-of-two
// reduction that is still at least as big as the avatar.
private fun ByteArray.decodeAvatar(targetPx: Int): ImageBitmap? {
    val bounds = BitmapFactory.Options().apply { inJustDecodeBounds = true }

    BitmapFactory.decodeByteArray(this, 0, size, bounds)

    if (bounds.outWidth <= 0 || bounds.outHeight <= 0) return null

    var sample = 1

    while (
        bounds.outWidth / (sample * 2) >= targetPx &&
        bounds.outHeight / (sample * 2) >= targetPx
    ) {
        sample *= 2
    }

    val options =
        BitmapFactory
            .Options()
            .apply { inSampleSize = sample }

    return BitmapFactory
        .decodeByteArray(this, 0, size, options)
        ?.asImageBitmap()
}