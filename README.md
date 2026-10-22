# Cakeday

Native Android app (Kotlin + Jetpack Compose) to save birthdays from your contacts, keep notes and
custom messages, and get **local reminders** so you do not miss a cake day. Tap the notification and
WhatsApp opens with the birthday message already written: you only have to hit send.

## Features

- Pick a contact from the device address book (with runtime permission handling)
- Store name, phone, date (optional year), photo, custom message, and note in a **local SQLite**
  database ([Room](https://developer.android.com/training/data-storage/room))
- **Scheduled reminders** (`AlarmManager` + `NotificationCompat`) on the day and, optionally, the
  day before, at the time you choose
- **WhatsApp shortcut**: tapping the notification opens the contact's chat with the message
  pre-filled
- **Global message** with a `{name}` placeholder, plus an optional **custom message per birthday**
- **Light / dark** theme with Material 3
- Search and grouped list of all birthdays
- English and Spanish

## Requirements

- [Android Studio](https://developer.android.com/studio) (latest stable)
- JDK 17 or newer (the one bundled with Android Studio works)
- Android device or emulator

## Getting started

```bash
git clone https://github.com/RaulCatalinas/Cakeday
cd Cakeday
```

Open the folder in Android Studio and let Gradle sync.

### Room code generation

Room generates its code at build time with KSP, so there is no separate generation step. If you
change the entities or DAOs, just rebuild the project.

## Run

From Android Studio, pick a device and press **Run** on the `app` configuration, or from the
terminal:

```bash
./gradlew installDebug
```

On Windows use `gradlew.bat installDebug`.

## Tech stack

| Area          | Libraries / notes                                         |
|---------------|-----------------------------------------------------------|
| Language      | Kotlin                                                    |
| UI            | Jetpack Compose, Material 3                               |
| Persistence   | Room (SQLite)                                             |
| Preferences   | Jetpack DataStore                                         |
| State         | `ViewModel` + `StateFlow`                                 |
| Contacts      | `ContactsContract` / `ActivityResultContracts`            |
| Notifications | `AlarmManager`, `BroadcastReceiver`, `NotificationCompat` |
| Localization  | Android string resources (`values/`, `values-es/`)        |

## Project layout (high level)

- `app/src/main/java/com/raulcatalinas/cakeday/`
    - `MainActivity.kt` — app entry, theme and navigation host
    - `ui/` — Compose screens (home, all birthdays, add birthday, settings) and reusable components
    - `data/` — Room database, entities, DAOs and repositories
    - `notifications/` — alarm scheduling, receivers (alarm, boot, time change) and WhatsApp intent
      building
    - `viewmodel/` — `ViewModel` classes exposing UI state
- `app/src/main/res/` — strings, themes, icons and splash resources

---

Contributions and issues are welcome.