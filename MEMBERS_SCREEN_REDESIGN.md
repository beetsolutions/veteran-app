# Members Screen Redesign Documentation

## Overview
This document describes the redesign of the Members screen to organize members into three distinct sections based on their status: Active, Suspended, and Dismissed members.

## Visual Design

### Members List Screen

```
╔══════════════════════════════════════════╗
║  ← Members                               ║
╠══════════════════════════════════════════╣
║  👥  Organization Members                ║
║      9 total • 5 active • 2 suspended •  ║
║      2 dismissed                         ║
╠══════════════════════════════════════════╣
║  🏷️ Active Members                    [5]║
╠══════════════════════════════════════════╣
║  ┌────────────────────────────────────┐  ║
║  │ (J) John Doe                     > │  ║
║  │     President • Army               │  ║
║  └────────────────────────────────────┘  ║
║  ┌────────────────────────────────────┐  ║
║  │ (J) Jane Smith                   > │  ║
║  │     Vice President • Navy          │  ║
║  └────────────────────────────────────┘  ║
║  ┌────────────────────────────────────┐  ║
║  │ (R) Robert Johnson               > │  ║
║  │     Secretary • Air Force          │  ║
║  └────────────────────────────────────┘  ║
║  ┌────────────────────────────────────┐  ║
║  │ (M) Mary Williams                > │  ║
║  │     Treasurer • Marines            │  ║
║  └────────────────────────────────────┘  ║
║  ┌────────────────────────────────────┐  ║
║  │ (J) James Brown                  > │  ║
║  │     Member • Coast Guard           │  ║
║  └────────────────────────────────────┘  ║
╠══════════════════════════════════════════╣
║  🏷️ Suspended Members                 [2]║
╠══════════════════════════════════════════╣
║  ┌────────────────────────────────────┐  ║
║  │ (P) Patricia Garcia              > │  ║
║  │     Member • Army                  │  ║
║  └────────────────────────────────────┘  ║
║  ┌────────────────────────────────────┐  ║
║  │ (M) Michael Davis                > │  ║
║  │     Member • Navy                  │  ║
║  └────────────────────────────────────┘  ║
╠══════════════════════════════════════════╣
║  🏷️ Dismissed Members                 [2]║
╠══════════════════════════════════════════╣
║  ┌────────────────────────────────────┐  ║
║  │ (T) Thomas Wilson                > │  ║
║  │     Member • Air Force             │  ║
║  └────────────────────────────────────┘  ║
║  ┌────────────────────────────────────┐  ║
║  │ (J) Jennifer Martinez            > │  ║
║  │     Member • Marines               │  ║
║  └────────────────────────────────────┘  ║
╚══════════════════════════════════════════╝
```

### Member Detail Screen

```
╔══════════════════════════════════════════╗
║  ← Member Details                        ║
╠══════════════════════════════════════════╣
║                                          ║
║           ╭───────────╮                  ║
║           │     J     │                  ║
║           ╰───────────╯                  ║
║                                          ║
║           John Doe                       ║
║           President                      ║
║                                          ║
╠══════════════════════════════════════════╣
║                                          ║
║  ┌────────────────────────────────────┐  ║
║  │  🎖️  Service Branch                │  ║
║  │                                    │  ║
║  │      Army                          │  ║
║  └────────────────────────────────────┘  ║
║                                          ║
║  ┌────────────────────────────────────┐  ║
║  │  💼  Role                           │  ║
║  │                                    │  ║
║  │      President                     │  ║
║  └────────────────────────────────────┘  ║
║                                          ║
║  ┌────────────────────────────────────┐  ║
║  │  ℹ️  Status                         │  ║
║  │                                    │  ║
║  │      Active Member (GREEN)         │  ║
║  └────────────────────────────────────┘  ║
║                                          ║
╚══════════════════════════════════════════╝
```

## Color Scheme

### Active Members
- **Color**: Green (shade700 for text)
- **Avatar**: Green background
- **Section Header**: Light green background (#E8F5E9)
- **Badge**: Green with light background

### Suspended Members
- **Color**: Orange (shade800 for text)
- **Avatar**: Orange background
- **Section Header**: Light orange background (#FFF3E0)
- **Badge**: Orange with light background

### Dismissed Members
- **Color**: Red (shade700 for text)
- **Avatar**: Red background
- **Section Header**: Light red background (#FFEBEE)
- **Badge**: Red with light background

## Key Features

### 1. Summary Header
- Shows total member count
- Breaks down counts by status (active, suspended, dismissed)
- Located at the top of the screen for quick overview

### 2. Sectioned Layout
- Members are grouped by status for easy navigation
- Each section has a color-coded header
- Section headers display the count of members in that section

### 3. Visual Status Indicators
- Avatar colors match member status
- Section headers use themed colors
- Consistent color coding throughout the interface

### 4. Member Detail Updates
- Status field now displays the actual member status
- Status text color matches the status (green/orange/red)
- Better contrast with darker shades for accessibility

## Technical Implementation

### Model Changes
```dart
enum MemberStatus {
  active,
  suspended,
  dismissed,
}

class Member {
  final String id;
  final String name;
  final String location;
  final bool isPaid;
  final MemberStatus status;
  
  const Member({
    required this.id,
    required this.name,
    required this.location,
    this.isPaid = false,
    this.status = MemberStatus.active,
  });
}
```

### UI Updates
1. **Members Tab**: Changed from a single list to a sectioned layout
2. **Member Detail**: Added status parameter with color-coded display
3. **Tests**: Updated to cover all three status types

## Accessibility
- Text contrast meets WCAG AA standards (4.5:1 ratio)
- Clear visual hierarchy with section headers
- Consistent color coding for easy recognition
- Large touch targets for mobile interaction

## Future Enhancements
- Add filtering to show/hide specific status sections
- Add search functionality across all member types
- Add member status change functionality with history tracking
- Add notifications when member status changes
