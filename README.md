# Cakeday

Flutter app to save birthdays from your contacts, keep notes and custom messages, and get **local reminders** so you do not miss a cake day.

## Features

- Pick a contact from the device address book (with permission handling)
- Store name, phone, date (optional year), photo, custom message, and note in a **local SQLite** database ([Drift](https://pub.dev/packages/drift))
- **Scheduled notifications** ([awesome_notifications](https://pub.dev/packages/awesome_notifications)) with app-wide defaults and per-birthday message when set
- **Light / dark** theme ([flutter_themed](https://pub.dev/packages/flutter_themed))
- Search and grouped list of all birthdays
- State and cache refresh with [Riverpod](https://pub.dev/packages/flutter_riverpod)

## Requirements

- [Flutter](https://docs.flutter.dev/get-started/install) (SDK **^3.11**)
- Android / iOS device or emulator (primary targets; desktop may work for local DB debugging)

## Getting started

```bash
git clone <https://github.com/RaulCatalinas/Cakeday>
cd cakeday
flutter pub get
```

### Drift code generation

If you change `lib/db/db.dart` (tables or queries), regenerate:

```bash
dart run build_runner build --delete-conflicting-outputs
```

## Run

```bash
flutter run
```

Pick a device with `flutter devices`.

## Tech stack

| Area        | Packages / notes        |
|------------|-------------------------|
| UI         | Material 3, Flutter     |
| Persistence | Drift + `sqlite3_flutter_libs` |
| DI / state | flutter_riverpod        |
| Contacts   | flutter_contacts        |
| Notifications | awesome_notifications |
| Preferences | shared_preferences     |

## Project layout (high level)

- `lib/main.dart` — app entry, theme bootstrap
- `lib/screens/` — screens (home, all birthdays, add birthday, settings)
- `lib/components/` — reusable widgets
- `lib/db/` — database and Drift-generated `db.g.dart`
- `lib/providers/` — Riverpod providers
- `lib/handlers/` — save flows and side effects

---

Contributions and issues are welcome.
