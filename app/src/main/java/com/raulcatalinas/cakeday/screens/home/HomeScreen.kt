package com.raulcatalinas.cakeday.screens.home

import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.rememberScrollState
import androidx.compose.foundation.verticalScroll
import androidx.compose.material3.Scaffold
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.res.stringResource
import androidx.compose.ui.unit.dp
import com.raulcatalinas.cakeday.R
import com.raulcatalinas.cakeday.shared.components.AppFloatingActionButton
import com.raulcatalinas.cakeday.shared.extensions.verticalScrollbar

@Composable
fun HomeScreen(onCreateBirthday: () -> Unit) {
    val scrollState = rememberScrollState()

    Scaffold(
        floatingActionButton = {
            AppFloatingActionButton(
                contentDescription =
                    stringResource(R.string.add_birthday)
            ) {
                onCreateBirthday()
            }
        }
    ) { paddingValues ->
        Column(
            modifier = Modifier
                .padding(paddingValues)
                .verticalScrollbar(scrollState)
                .verticalScroll(scrollState)
                .padding(horizontal = 20.dp, vertical = 16.dp)
                .fillMaxSize(),
            horizontalAlignment = Alignment.CenterHorizontally,
            verticalArrangement = Arrangement.spacedBy(16.dp),
        ) {
            Text("Home screen")
        }
    }
}