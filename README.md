# URL Player

A Flutter video player application that streams content from various URL sources with advanced playback controls. Built with clean architecture principles and modern Flutter best practices.

## Features

- 🎥 **Video Playback**: Play videos from network URLs with support for multiple stream qualities
- 🔍 **Search Functionality**: Search through saved video links by title or URL
- ⏯️ **Playback Controls**: Full-featured controls (play/pause, seek forward/backward)
- 🔊 **Audio Controls**: Volume control and mute toggle
- 🏎️ **Playback Speed**: Adjustable playback speed
- 🖥️ **Fullscreen Mode**: Immersive fullscreen video experience
- 📶 **Quality Selection**: Support for adaptive streams with quality selection
- 💾 **Link Management**: Save, edit, and delete video links locally
- 🌓 **Theme Support**: Light and dark theme modes
- 🔐 **DRM Support**: ClearKey DRM support for protected content
- 📱 **Cross-Platform**: Supports Android, iOS, Web, Windows, Linux, and macOS
- 🔗 **Intent Handling**: Receive video streams from external applications

## Architecture

This project follows **Clean Architecture** principles with clear separation of concerns:

```
lib/
├── core/              # Core utilities, services, and infrastructure
│   ├── database/      # Database helpers and ObjectBox integration
│   ├── services/     # Service locator and dependency injection
│   ├── theme/        # Application theming
│   ├── utils/        # Utility functions (player, intent handling)
│   ├── error/        # Error handling (Either pattern, Failures)
│   └── either/       # Either monad implementation
├── data/             # Data layer
│   ├── models/       # Data models (LinkModel, StreamModel)
│   ├── datasources/  # Local data sources
│   └── repositories/ # Repository implementations
├── domain/           # Business logic layer
│   ├── entities/     # Domain entities (LinkEntity)
│   └── repositories/  # Repository interfaces
└── presentation/     # UI layer
    ├── bloc/         # State management (BLoC pattern)
    ├── screens/      # Application screens
    └── widgets/      # Reusable UI components
```

## Technology Stack

### Core Dependencies

- **flutter_bloc** (^9.1.0): State management using BLoC pattern
- **objectbox** (^5.1.0): High-performance local database
- **awesome_video_player**: Custom video player with advanced features
- **get_it** (^9.2.0): Dependency injection
- **shared_preferences** (^2.5.3): Local settings storage
- **animated_text_kit** (^4.2.3): Text animations
- **uuid** (^4.5.1): Unique identifier generation
- **url_launcher** (^6.3.2): Launch URLs in external browser

### Development Dependencies

- **build_runner**: Code generation
- **objectbox_generator**: ObjectBox code generation
- **flutter_lints** (^5.0.0): Linting rules

## Installation

### Prerequisites

- Flutter SDK (3.7.0 or higher)
- Dart SDK
- Android Studio / Xcode (for mobile development)
- Git

### Steps

1. **Clone the repository:**

   ```bash
   git clone https://github.com/Mazen-Almortada/tsalul-url-player.git
   cd tsalul-url-player
   ```

2. **Install dependencies:**

   ```bash
   flutter pub get
   ```

3. **Generate ObjectBox code:**

   ```bash
   flutter pub run build_runner build
   ```

4. **Run the application:**
   ```bash
   flutter run
   ```

## Usage

### Adding a Video Link

1. Tap the floating action button (+) on the home screen
2. Enter a title and URL for the video
3. Tap "Save Link" to store it locally

### Playing a Video

1. From the home screen, tap the play icon on any saved link
2. Or, receive video data from an external application via intent

### Searching Links

1. Tap the search bar on the home screen
2. Enter keywords to search by title or URL
3. Results update in real-time

### Theme Switching

- Use the theme toggle button in the app bar to switch between light and dark modes

## Platform-Specific Setup

### Android

The app requires platform channel setup for intent handling. Ensure your `MainActivity.kt` implements the intent channel:

```kotlin
// Example implementation needed in native Android code
```

### iOS

Similar platform channel setup required for iOS in `AppDelegate.swift`.

## Error Handling

The application includes comprehensive error handling with user-friendly messages:

- **Cache Failures**: Database operation errors with helpful messages
- **Network Failures**: Connection issues with retry suggestions
- **Platform Failures**: Intent handling errors with guidance

## Contributing

Contributions are welcome! Please follow these steps:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is private and not intended for publication.

## Support

For issues and questions, please open an issue on the GitHub repository.

## Acknowledgments

- Video player powered by [awesome_video_player](https://github.com/Mazen-Almortada/awesome_video_player)
- Built with Flutter and Dart
