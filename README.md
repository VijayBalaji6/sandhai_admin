# Sandhai Admin

Admin application for a fruits & vegetables shop — targeting Android, Web (Windows), and macOS.

## Architecture

This project uses a simple Clean Architecture layout with:

- **BLoC**: `flutter_bloc`
- **Routing**: `go_router`

Folder structure (main parts):

- `lib/app/`: app shell (router, top-level `MaterialApp.router`)
- `lib/core/`: shared utilities (theme, constants, common widgets)
- `lib/features/`: feature modules (each feature can have `data/`, `domain/`, `presentation/`)

## Run

```bash
flutter pub get
flutter run
```

