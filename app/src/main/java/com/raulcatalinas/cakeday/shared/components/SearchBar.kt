package com.raulcatalinas.cakeday.shared.components

import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.Close
import androidx.compose.material.icons.filled.Search
import androidx.compose.material3.Icon
import androidx.compose.material3.IconButton
import androidx.compose.runtime.Composable
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableIntStateOf
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.rememberUpdatedState
import androidx.compose.runtime.saveable.rememberSaveable
import androidx.compose.runtime.setValue
import androidx.compose.runtime.snapshotFlow
import androidx.compose.ui.Modifier
import androidx.compose.ui.res.stringResource
import com.raulcatalinas.cakeday.R
import kotlinx.coroutines.FlowPreview
import kotlinx.coroutines.flow.debounce
import kotlinx.coroutines.flow.distinctUntilChanged
import kotlin.time.Duration
import kotlin.time.Duration.Companion.milliseconds

@OptIn(FlowPreview::class)
@Composable
fun AppSearchBar(
    modifier: Modifier = Modifier,
    placeholder: String = stringResource(R.string.search_birthdays_hint),
    debounceTime: Duration = 250.milliseconds,
    onQueryChange: (String) -> Unit,
) {
    var hasText by rememberSaveable { mutableStateOf(false) }
    var rawQuery by rememberSaveable { mutableStateOf("") }

    var clearSignal by remember { mutableIntStateOf(0) }
    val currentOnQueryChange by rememberUpdatedState(onQueryChange)

    LaunchedEffect(Unit) {
        snapshotFlow { rawQuery }
            .debounce {
                if (it.isEmpty()) Duration.ZERO
                else debounceTime
            }
            .distinctUntilChanged()
            .collect { currentOnQueryChange(it) }
    }

    Input(
        modifier = modifier,
        isOutlined = true,
        placeholder = placeholder,
        clearSignal = clearSignal,
        trailingIcon = {
            if (hasText) {
                IconButton(onClick = { clearSignal++ }) {
                    Icon(
                        imageVector = Icons.Default.Close,
                        contentDescription = stringResource(R.string.clear_search)
                    )
                }
            } else {
                Icon(
                    imageVector = Icons.Default.Search,
                    contentDescription = null
                )
            }
        },
        onTyping = {
            hasText = it.isNotEmpty()
            rawQuery = it
        }
    )
}