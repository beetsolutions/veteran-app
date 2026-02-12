# veteranapp

Veteran App - A Flutter application for veteran organizations

## Recent Updates

🎥 **NEW: Video Background on Login Screen**

The login screen now features a dynamic video background:
- Auto-playing looped video behind the login form
- Muted video with dark overlay for optimal text readability
- Graceful degradation if video asset is missing
- Maintains all existing functionality and UI elements
- Optimized for performance with hardware acceleration

See [Video Background Implementation](VIDEO_BACKGROUND_IMPLEMENTATION.md) for complete technical details.

🌓 **Dark and Light Theme Support**

The app now supports both dark and light themes that users can switch between:
- Toggle theme in Settings screen
- Smooth transitions between themes
- Well-designed color schemes for both modes
- Theme-aware components throughout the app

See [Theme System Documentation](THEME_SYSTEM.md) for developer guide and [Implementation Summary](THEME_IMPLEMENTATION_SUMMARY.md) for complete details.

📊 **Dashboard Features**

The home screen now features a comprehensive dashboard with:
- Statistics cards showing total members and account balance
- Officials section displaying organization leadership (max 4 with "Show All")
- News section with latest updates (max 3 with "Show All")

See [Dashboard Implementation](DASHBOARD_IMPLEMENTATION.md) for complete details.

🎨 **Spotify-Style Login Screen**

The login screen has been completely redesigned with a modern, dark theme inspired by Spotify's interface:

- [📐 Design Documentation](DESIGN_DOCUMENTATION.md) - Complete design specifications
- [🎨 Visual Mockup](VISUAL_MOCKUP.md) - ASCII art mockups and layout guides
- [📊 Implementation Summary](IMPLEMENTATION_SUMMARY.md) - Full project summary
- [🔄 Before/After Comparison](BEFORE_AFTER_COMPARISON.md) - Visual comparison

## Key Features
- 🎥 Dynamic video background on login screen
- 🌓 Dark and light theme switching
- 📊 Interactive dashboard with statistics and updates
- 👥 Officials directory with detailed cards
- 📰 News feed with categorized updates
- ✨ Spotify green accent (dark mode) / Blue theme (light mode)
- 🔐 Social login options (Facebook, Apple, Google)
- 📧 Email/password authentication
- 🎯 Two-step login flow
- 📱 Modern, mobile-first design

## Getting Started

### Backend API Integration

The app now has **two backend options** available:

#### Option 1: Node.js Backend (Express)

```bash
cd backend
npm install
npm start
```
Server runs on `http://localhost:3000`

#### Option 2: Spring Boot Backend (Java)

```bash
cd springboot-backend
mvn spring-boot:run
```
Server runs on `http://localhost:8080`

**Choose the backend that best fits your team's expertise!** Both provide identical functionality.
See [BACKEND_COMPARISON.md](BACKEND_COMPARISON.md) for detailed comparison.

#### Run the Flutter App

```bash
flutter run
```

**Platform-Specific Configuration:**

For **Node.js Backend** (port 3000):
- **iOS Simulator**: `http://localhost:3000`
- **Android Emulator**: `http://10.0.2.2:3000`
- **Physical Device**: `http://YOUR_LOCAL_IP:3000`

For **Spring Boot Backend** (port 8080):
- **iOS Simulator**: `http://localhost:8080`
- **Android Emulator**: `http://10.0.2.2:8080`
- **Physical Device**: `http://YOUR_LOCAL_IP:8080`

Update `lib/data/api/api_client.dart` baseUrl as needed.

For detailed integration instructions, see [INTEGRATION_GUIDE.md](INTEGRATION_GUIDE.md).

### Flutter Resources

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
