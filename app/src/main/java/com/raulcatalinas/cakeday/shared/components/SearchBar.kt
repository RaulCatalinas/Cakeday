package com.raulcatalinas.cakeday.shared.components

import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.Close
import androidx.compose.material.icons.filled.Search
import androidx.compose.material3.Icon
import androidx.compose.material3.IconButton
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableIntStateOf
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.saveable.rememberSaveable
import androidx.compose.runtime.setValue
import androidx.compose.ui.Modifier
import androidx.compose.ui.res.stringResource
import com.raulcatalinas.cakeday.R

@Composable
fun AppSearchBar(
    modifier: Modifier = Modifier,
    onQueryChange: (String) -> Unit,
) {
    var hasText by rememberSaveable { mutableStateOf(false) }
    var clearSignal by remember { mutableIntStateOf(0) }

    Input(
        modifier = modifier,
        isOutlined = true,
        placeholder = stringResource(R.string.search_birthdays_hint),
        clearSignal = clearSignal,
        trailingIcon = trailingIcon@{
            if (!hasText) {
                Icon(
                    imageVector = Icons.Default.Search,
                    contentDescription = null
                )

                return@trailingIcon
            }

            IconButton(onClick = { clearSignal++ }) {
                Icon(
                    imageVector = Icons.Default.Close,
                    contentDescription = stringResource(R.string.clear_search)
                )
            }
        },
        onTyping = {
            hasText = it.isNotEmpty()
            onQueryChange(it)
        }
    )
}