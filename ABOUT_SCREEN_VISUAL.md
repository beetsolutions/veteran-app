# About Screen - Visual Representation

## Screen Preview

```
╔═══════════════════════════════════════════╗
║  ←  About                                 ║  <- AppBar with back button
╠═══════════════════════════════════════════╣
║                                           ║
║              🪖 (100px)                   ║  <- Military tech icon
║                                           ║     (Primary color)
║           VeteranApp                      ║  <- App name (28pt, bold)
║          Version 1.0.0                    ║  <- Version (16pt, grey)
║                                           ║
║  ─────────────────────────────────────    ║
║                                           ║
║  About VeteranApp                         ║  <- Section title (20pt, bold)
║                                           ║
║  VeteranApp is a comprehensive            ║  <- Description text
║  application designed to serve            ║     (16pt, line height 1.5)
║  veteran organizations. Our mission       ║
║  is to provide a centralized              ║
║  platform for veterans to stay            ║
║  connected, informed, and engaged         ║
║  with their community.                    ║
║                                           ║
║  ─────────────────────────────────────    ║
║                                           ║
║  Features                                 ║  <- Section title
║                                           ║
║  📊 Dashboard                             ║  <- Feature item
║     Access statistics, news, and          ║     Icon + Title + Description
║     officials at a glance                 ║
║                                           ║
║  👥 Member Directory                      ║
║     Connect with fellow veterans          ║
║     in your organization                  ║
║                                           ║
║  🏠 Hosting Schedule                      ║
║     Track and manage member               ║
║     hosting rotations                     ║
║                                           ║
║  📊 Activity Statistics                   ║
║     Monitor engagement and                ║
║     participation metrics                 ║
║                                           ║
║  📄 Constitution                          ║
║     Access organization rules             ║
║     and guidelines                        ║
║                                           ║
║  ─────────────────────────────────────    ║
║                                           ║
║  Contact & Support                        ║  <- Section title
║                                           ║
║  ╔═══════════════════════════════════╗   ║
║  ║ 📧  Email                         ║   ║  <- Card with icon
║  ║     support@veteranapp.com        ║   ║     and information
║  ╚═══════════════════════════════════╝   ║
║                                           ║
║  ╔═══════════════════════════════════╗   ║
║  ║ 🌐  Website                       ║   ║
║  ║     www.veteranapp.com            ║   ║
║  ╚═══════════════════════════════════╝   ║
║                                           ║
║  ─────────────────────────────────────    ║
║                                           ║
║  Legal                                    ║  <- Section title
║                                           ║
║  ╔═══════════════════════════════════╗   ║
║  ║  Privacy Policy               →   ║   ║  <- Tappable card
║  ╚═══════════════════════════════════╝   ║     with chevron
║                                           ║
║  ╔═══════════════════════════════════╗   ║
║  ║  Terms of Service             →   ║   ║
║  ╚═══════════════════════════════════╝   ║
║                                           ║
║  ╔═══════════════════════════════════╗   ║
║  ║  Open Source Licenses         →   ║   ║
║  ╚═══════════════════════════════════╝   ║
║                                           ║
║  ─────────────────────────────────────    ║
║                                           ║
║      © 2026 VeteranApp.                  ║  <- Copyright
║      All rights reserved.                 ║     (14pt, grey, centered)
║                                           ║
╚═══════════════════════════════════════════╝
```

## Color Scheme

- **Primary Color**: Used for icon, interactive elements
- **Text Colors**:
  - Main text: Default (black/dark)
  - Secondary text: Grey (600)
  - Titles: Bold, black
- **Cards**: White with subtle elevation/shadow
- **Icons**: Blue for features, matching theme for others

## Interaction

1. **Scroll**: Entire screen is scrollable (SingleChildScrollView)
2. **Back Button**: Returns to More screen
3. **Legal Items**: Tappable (future implementation for actual pages)
4. **Responsive**: Adapts to different screen sizes

## Spacing

- Padding: 16px on sides
- Section spacing: 24-32px
- Item spacing: 12-16px within sections
- Icon size: 100px (main), 24px (features), standard (cards)

## Typography

- App Name: 28pt, bold
- Version: 16pt, grey
- Section Titles: 20pt, bold
- Feature Titles: 16pt, semi-bold
- Body Text: 16pt (description), 14pt (features)
- Copyright: 14pt, grey

## Navigation Path

```
Home Screen
    ↓
Bottom Navigation Bar → More Tab
    ↓
More Screen (ListView of menu items)
    ↓
Tap "About" menu item
    ↓
About Screen (This screen)
```

## Implementation Notes

- Follows Material Design guidelines
- Consistent with other screens in the app
- Uses standard Flutter widgets (Scaffold, AppBar, ListView, Card, etc.)
- Fully accessible with semantic widgets
- Supports dark mode (uses Theme.of(context))
