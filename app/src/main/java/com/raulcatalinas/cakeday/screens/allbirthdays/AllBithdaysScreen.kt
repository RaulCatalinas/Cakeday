package com.raulcatalinas.cakeday.screens.allbirthdays

import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.items
import androidx.compose.foundation.lazy.rememberLazyListState
import androidx.compose.material3.Card
import androidx.compose.material3.Scaffold
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.remember
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.platform.LocalConfiguration
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import com.raulcatalinas.cakeday.screens.allbirthdays.types.BirthdayItem
import com.raulcatalinas.cakeday.screens.allbirthdays.types.HeaderItem
import com.raulcatalinas.cakeday.screens.allbirthdays.utils.BirthdayDateFormatter
import com.raulcatalinas.cakeday.shared.extensions.normalizedInitial
import com.raulcatalinas.cakeday.shared.extensions.verticalScrollbar
import com.raulcatalinas.cakeday.shared.types.BirthdayData
import com.raulcatalinas.cakeday.shared.types.ContactInfo
import java.text.Collator
import kotlin.time.Instant

val testBirthdays = listOf(
    BirthdayData(
        id = 1,
        contactInfo = ContactInfo("Ana García", "600000001"),
        birthday = Instant.parse("1998-01-15T00:00:00Z"),
        includeYear = true,
        note = "Amiga de la infancia",
        notificationScheduled = true
    ),
    BirthdayData(
        id = 2,
        contactInfo = ContactInfo("Carlos Martín", "600000002"),
        birthday = Instant.parse("2001-02-28T00:00:00Z"),
    ),
    BirthdayData(
        id = 3,
        contactInfo = ContactInfo("Lucía Fernández"),
        birthday = Instant.parse("1995-03-01T00:00:00Z"),
        includeYear = true,
        note = "Le gusta recibir felicitaciones por WhatsApp",
        notificationScheduled = true
    ),
    BirthdayData(
        id = 4,
        contactInfo = ContactInfo("David López", "600000004"),
        birthday = Instant.parse("2000-04-20T00:00:00Z"),
        includeYear = false,
        note = "Compañero de clase",
        notificationScheduled = true
    ),
    BirthdayData(
        id = 5,
        contactInfo = ContactInfo("Marta Sánchez"),
        birthday = Instant.parse("1987-05-10T00:00:00Z"),
        includeYear = true,
    ),
    BirthdayData(
        id = 6,
        contactInfo = ContactInfo("Javier Ruiz", "600000006"),
        birthday = Instant.parse("1999-06-30T00:00:00Z"),
        notificationScheduled = true
    ),
    BirthdayData(
        id = 7,
        contactInfo = ContactInfo("Sofía Torres", "600000007"),
        birthday = Instant.parse("2002-07-04T00:00:00Z"),
        includeYear = true,
        note = "Le encantan los animales",
    ),
    BirthdayData(
        id = 8,
        contactInfo = ContactInfo("Pablo Moreno"),
        birthday = Instant.parse("1994-08-21T00:00:00Z"),
        note = "Amigo del fútbol",
        notificationScheduled = true
    ),
    BirthdayData(
        id = 9,
        contactInfo = ContactInfo("Elena Jiménez", "600000009"),
        birthday = Instant.parse("1990-09-12T00:00:00Z"),
        includeYear = true,
    ),
    BirthdayData(
        id = 10,
        contactInfo = ContactInfo("Alberto Díaz", "600000010"),
        birthday = Instant.parse("2003-10-31T00:00:00Z"),
        note = "Cumpleaños en Halloween",
        notificationScheduled = true
    ),
    BirthdayData(
        id = 11,
        contactInfo = ContactInfo("Paula Romero"),
        birthday = Instant.parse("1997-11-25T00:00:00Z"),
        includeYear = true,
        note = "Amiga del trabajo",
        notificationScheduled = true
    ),
    BirthdayData(
        id = 12,
        contactInfo = ContactInfo("Diego Navarro", "600000012"),
        birthday = Instant.parse("1992-12-31T00:00:00Z"),
        note = "Cumpleaños en Nochevieja",
    ),
    BirthdayData(
        id = 13,
        contactInfo = ContactInfo("María Ortega", "600000013"),
        birthday = Instant.parse("2000-02-29T00:00:00Z"),
        includeYear = true,
        note = "Nació en año bisiesto",
        notificationScheduled = true
    ),
    BirthdayData(
        id = 14,
        contactInfo = ContactInfo("Álvaro Castro"),
        birthday = Instant.parse("1985-06-15T00:00:00Z"),
    ),
    BirthdayData(
        id = 15,
        contactInfo = ContactInfo("Nuria Vega", "600000015"),
        birthday = Instant.parse("2005-10-23T00:00:00Z"),
        includeYear = true,
        note = "Cumpleaños en la fecha actual",
        notificationScheduled = true
    )
)

@Composable
fun AllBirthdaysScreen() {
    val listState = rememberLazyListState()

    val locale = LocalConfiguration.current.locales[0]

    val listItems = remember(testBirthdays, locale) {
        val collator = Collator.getInstance(locale).apply { strength = Collator.PRIMARY }
        val dateFormatter = BirthdayDateFormatter(locale)

        buildList {
            testBirthdays
                .map { it to collator.getCollationKey(it.contactInfo.name) }
                .sortedBy { it.second }
                .map { it.first }
                .groupBy { it.contactInfo.name.normalizedInitial }
                .forEach { (letter, birthdays) ->
                    add(HeaderItem(letter))
                    birthdays.forEach {
                        add(
                            BirthdayItem(
                                it,
                                dateFormatter.format(
                                    it.birthday,
                                    it.includeYear
                                )
                            )
                        )
                    }
                }
        }
    }

    Scaffold { paddingValues ->
        Column(
            modifier = Modifier
                .padding(paddingValues)
                .padding(horizontal = 20.dp, vertical = 16.dp)
                .fillMaxSize(),
            horizontalAlignment = Alignment.CenterHorizontally,
            verticalArrangement = Arrangement.spacedBy(16.dp),
        ) {
            // TODO: Add search bar

            LazyColumn(
                modifier =
                    Modifier
                        .verticalScrollbar(listState)
                        .fillMaxWidth(),
                verticalArrangement = Arrangement.spacedBy(16.dp),
                state = listState,
            ) {
                items(
                    items = listItems,
                    key = { it.key },
                    contentType = { it.contentType }
                ) { item ->
                    when (item) {
                        is HeaderItem -> Text(
                            item.titleChar.toString(),
                            fontSize = 11.sp
                        )

                        is BirthdayItem -> BirthdayCard(
                            item.data,
                            item.dateText
                        )
                    }
                }
            }
        }
    }
}

@Composable
private fun BirthdayCard(birthdayData: BirthdayData, dateText: String) {
    Card(modifier = Modifier.fillMaxWidth()) {
        Column(
            modifier = Modifier.padding(16.dp),
            verticalArrangement = Arrangement.spacedBy(4.dp)
        ) {
            Text(birthdayData.contactInfo.name, fontSize = 18.sp)
            Text(dateText, fontSize = 15.sp)
        }
    }
}