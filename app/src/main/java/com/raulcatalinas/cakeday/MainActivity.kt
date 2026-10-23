package com.raulcatalinas.cakeday

import android.os.Bundle
import androidx.activity.compose.setContent
import androidx.activity.enableEdgeToEdge
import androidx.annotation.StringRes
import androidx.appcompat.app.AppCompatActivity
import androidx.compose.foundation.layout.size
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.Cake
import androidx.compose.material.icons.filled.People
import androidx.compose.material.icons.filled.Settings
import androidx.compose.material3.Icon
import androidx.compose.material3.Text
import androidx.compose.material3.adaptive.navigationsuite.NavigationSuiteScaffold
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.vector.ImageVector
import androidx.compose.ui.res.stringResource
import androidx.compose.ui.tooling.preview.PreviewScreenSizes
import androidx.compose.ui.unit.dp
import androidx.core.splashscreen.SplashScreen.Companion.installSplashScreen
import androidx.hilt.lifecycle.viewmodel.compose.hiltViewModel
import androidx.lifecycle.compose.collectAsStateWithLifecycle
import androidx.navigation.NavGraph.Companion.findStartDestination
import androidx.navigation.compose.NavHost
import androidx.navigation.compose.composable
import androidx.navigation.compose.currentBackStackEntryAsState
import androidx.navigation.compose.rememberNavController
import com.raulcatalinas.cakeday.screens.allbirthdays.AllBirthdaysScreen
import com.raulcatalinas.cakeday.screens.home.HomeScreen
import com.raulcatalinas.cakeday.screens.settings.SettingsScreen
import com.raulcatalinas.cakeday.screens.settings.viewmodels.SettingsViewModel
import com.raulcatalinas.cakeday.ui.theme.CakedayTheme
import dagger.hilt.android.AndroidEntryPoint

@AndroidEntryPoint
class MainActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        installSplashScreen()
        super.onCreate(savedInstanceState)
        enableEdgeToEdge()
        setContent {
            val settingsViewModel: SettingsViewModel = hiltViewModel()

            val settings by settingsViewModel.settings.collectAsStateWithLifecycle()

            CakedayTheme(theme = settings.theme) {
                CakedayApp()
            }
        }
    }
}

@PreviewScreenSizes
@Composable
fun CakedayApp() {
    val navController = rememberNavController()

    val navBackStackEntry by navController.currentBackStackEntryAsState()
    val currentRoute = navBackStackEntry?.destination?.route

    NavigationSuiteScaffold(
        navigationSuiteItems = {
            AppDestinations.entries.forEach { destination ->
                val isSelected = currentRoute == destination.name

                item(
                    icon = {
                        Icon(
                            imageVector = destination.icon,
                            contentDescription = stringResource(destination.labelRes),
                            modifier = Modifier.size(destination.iconSize.dp)
                        )
                    },
                    label = { Text(stringResource(destination.labelRes)) },
                    selected = isSelected,
                    onClick = {
                        if (isSelected) return@item

                        navController.navigate(destination.name) {
                            popUpTo(navController.graph.findStartDestination().id) {
                                saveState = true
                            }

                            launchSingleTop = true
                            restoreState = true
                        }
                    }
                )
            }
        }
    ) {
        NavHost(
            navController = navController,
            startDestination = AppDestinations.HOME.name
        ) {
            AppDestinations.entries.forEach { destination ->
                composable(destination.name) {
                    destination.content()
                }
            }
        }
    }
}

enum class AppDestinations(
    @StringRes val labelRes: Int,
    val icon: ImageVector,
    val iconSize: Int = 24,
    val content: @Composable () -> Unit,
) {
    HOME(
        labelRes = R.string.home_route,
        icon = Icons.Default.Cake,
        content = { HomeScreen() }
    ),
    ALL_BIRTHDAYS(
        labelRes = R.string.all_birthdays_route,
        icon = Icons.Default.People,
        content = { AllBirthdaysScreen() }
    ),
    SETTINGS(
        labelRes = R.string.settings_route,
        icon = Icons.Default.Settings,
        content = { SettingsScreen() }
    ),
}