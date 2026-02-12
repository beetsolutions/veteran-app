# Organization Switching UI - Visual Design

## Overview
This document describes the visual design of the organization switching feature on the home screen.

---

## Screen 1: Home Screen - Single Organization User

**User**: janesmith (belongs to 1 organization)

```
┌─────────────────────────────────────────┐
│  Veterans United               [    ]   │  <- AppBar (no swap icon)
└─────────────────────────────────────────┘
│                                         │
│  ┌────────────┐    ┌────────────────┐  │
│  │   👥 150   │    │   💰 $25,000   │  │
│  │Total Members│   │Account Balance│  │
│  └────────────┘    └────────────────┘  │
│                                         │
│  Officials                  Show All >  │
│  ┌─────────────────────────────────┐   │
│  │ 👤 Etukeni Ndecha               │   │
│  │    President • Army             │   │
│  └─────────────────────────────────┘   │
│  ┌─────────────────────────────────┐   │
│  │ 👤 Jane Smith                   │   │
│  │    Vice President • Navy        │   │
│  └─────────────────────────────────┘   │
│                                         │
│  Latest News                Show All >  │
│  ┌─────────────────────────────────┐   │
│  │ 📰 Annual Veterans Day Ceremony │   │
│  │    Nov 11, 2026 • Events        │   │
│  └─────────────────────────────────┘   │
│                                         │
└─────────────────────────────────────────┘
│[🏠] [📄] [👥] [⋯]│  <- Bottom Navigation
└───────────────────┘
```

**Key Features:**
- AppBar shows organization name: "Veterans United"
- No swap icon (user only has 1 organization)
- Clean, uncluttered interface

---

## Screen 2: Home Screen - Multiple Organization User

**User**: admin (belongs to 3 organizations)

```
┌─────────────────────────────────────────┐
│  Veterans United               [⇄]     │  <- AppBar with swap icon
└─────────────────────────────────────────┘
│                                         │
│  ┌────────────┐    ┌────────────────┐  │
│  │   👥 150   │    │   💰 $25,000   │  │
│  │Total Members│   │Account Balance│  │
│  └────────────┘    └────────────────┘  │
│                                         │
│  Officials                  Show All >  │
│  ┌─────────────────────────────────┐   │
│  │ 👤 Etukeni Ndecha               │   │
│  │    President • Army             │   │
│  └─────────────────────────────────┘   │
│  ┌─────────────────────────────────┐   │
│  │ 👤 Jane Smith                   │   │
│  │    Vice President • Navy        │   │
│  └─────────────────────────────────┘   │
│                                         │
│  Latest News                Show All >  │
│  ┌─────────────────────────────────┐   │
│  │ 📰 Annual Veterans Day Ceremony │   │
│  │    Nov 11, 2026 • Events        │   │
│  └─────────────────────────────────┘   │
│                                         │
└─────────────────────────────────────────┘
│[🏠] [📄] [👥] [⋯]│  <- Bottom Navigation
└───────────────────┘
```

**Key Features:**
- AppBar shows current organization: "Veterans United"
- Swap icon (⇄) visible in top-right corner
- Tapping swap icon opens organization dialog

---

## Screen 3: Organization Selection Dialog

**User**: admin (tapping the swap icon)

```
┌─────────────────────────────────────────┐
│  Veterans United               [⇄]     │
└─────────────────────────────────────────┘
│                                         │
│     ┌───────────────────────────┐      │
│     │ Switch Organization       │      │
│     ├───────────────────────────┤      │
│     │                           │      │
│     │ 🏢 Veterans United    ✓  │ <- Current (Blue)
│     │    New York, NY           │      │
│     │                           │      │
│     │ 🏢 Heroes Association     │      │
│     │    Los Angeles, CA        │      │
│     │                           │      │
│     │ 🏢 Freedom Veterans       │      │
│     │    Chicago, IL            │      │
│     │                           │      │
│     ├───────────────────────────┤      │
│     │              [Cancel]     │      │
│     └───────────────────────────┘      │
│                                         │
│                                         │
└─────────────────────────────────────────┘
│[🏠] [📄] [👥] [⋯]│
└───────────────────┘
```

**Key Features:**
- Dialog title: "Switch Organization"
- Each organization shows:
  - 🏢 Business icon
  - Organization name (bold if current)
  - Location
  - ✓ Checkmark for current organization
- Current organization in blue color
- Current organization not tappable
- Other organizations tappable to switch
- Cancel button to close dialog

---

## Screen 4: Switching in Progress

**User**: admin (after tapping "Heroes Association")

```
┌─────────────────────────────────────────┐
│  Veterans United               [⇄]     │
└─────────────────────────────────────────┘
│                                         │
│           ┌─────────────┐              │
│           │             │              │
│           │      ⌛      │              │
│           │             │              │
│           │  Loading... │              │
│           │             │              │
│           └─────────────┘              │
│                                         │
│                                         │
│                                         │
│                                         │
│                                         │
└─────────────────────────────────────────┘
│[🏠] [📄] [👥] [⋯]│
└───────────────────┘
```

**Key Features:**
- Centered loading indicator
- Non-dismissible (no tap to close)
- Shows briefly while API call completes

---

## Screen 5: Switch Success - Updated Home Screen

**User**: admin (after successful switch to Heroes Association)

```
┌─────────────────────────────────────────┐
│  Heroes Association            [⇄]     │  <- Updated AppBar title
└─────────────────────────────────────────┘
│ ✅ Switched to Heroes Association       │  <- Success message
│  ┌────────────┐    ┌────────────────┐  │
│  │   👥 150   │    │   💰 $25,000   │  │
│  │Total Members│   │Account Balance│  │
│  └────────────┘    └────────────────┘  │
│                                         │
│  Officials                  Show All >  │
│  ┌─────────────────────────────────┐   │
│  │ 👤 Etukeni Ndecha               │   │
│  │    President • Army             │   │
│  └─────────────────────────────────┘   │
│  ┌─────────────────────────────────┐   │
│  │ 👤 Jane Smith                   │   │
│  │    Vice President • Navy        │   │
│  └─────────────────────────────────┘   │
│                                         │
│  Latest News                Show All >  │
│  ┌─────────────────────────────────┐   │
│  │ 📰 Annual Veterans Day Ceremony │   │
│  │    Nov 11, 2026 • Events        │   │
│  └─────────────────────────────────┘   │
│                                         │
└─────────────────────────────────────────┘
│[🏠] [📄] [👥] [⋯]│
└───────────────────┘
```

**Key Features:**
- AppBar updated to show "Heroes Association"
- Green success snackbar at top
- Message: "Switched to Heroes Association"
- Swap icon still visible for further switches
- Success message auto-dismisses after 3-4 seconds

---

## Screen 6: Switch Error

**User**: admin (if switch fails - network error, etc.)

```
┌─────────────────────────────────────────┐
│  Veterans United               [⇄]     │
└─────────────────────────────────────────┘
│ ❌ Failed to switch organization: ...   │  <- Error message
│  ┌────────────┐    ┌────────────────┐  │
│  │   👥 150   │    │   💰 $25,000   │  │
│  │Total Members│   │Account Balance│  │
│  └────────────┘    └────────────────┘  │
│                                         │
│  Officials                  Show All >  │
│  ┌─────────────────────────────────┐   │
│  │ 👤 Etukeni Ndecha               │   │
│  │    President • Army             │   │
│  └─────────────────────────────────┘   │
│  ┌─────────────────────────────────┐   │
│  │ 👤 Jane Smith                   │   │
│  │    Vice President • Navy        │   │
│  └─────────────────────────────────┘   │
│                                         │
│  Latest News                Show All >  │
│  ┌─────────────────────────────────┐   │
│  │ 📰 Annual Veterans Day Ceremony │   │
│  │    Nov 11, 2026 • Events        │   │
│  └─────────────────────────────────┘   │
│                                         │
└─────────────────────────────────────────┘
│[🏠] [📄] [👥] [⋯]│
└───────────────────┘
```

**Key Features:**
- Red error snackbar at top
- Message: "Failed to switch organization: [error]"
- Organization remains unchanged
- User can try again
- Error message auto-dismisses after 3-4 seconds

---

## Design Specifications

### Colors
- **Primary Blue**: `#2196F3` - Current organization highlight
- **Success Green**: `#4CAF50` - Success messages
- **Error Red**: `#F44336` - Error messages
- **Gray**: `#9E9E9E` - Non-selected organizations

### Typography
- **AppBar Title**: 20px, Medium weight
- **Organization Name**: 16px, Bold (current), Regular (others)
- **Organization Location**: 14px, Regular, Gray

### Spacing
- **Dialog Padding**: 24px
- **List Item Height**: 72px
- **Icon Size**: 24x24px

### Icons
- **Swap Icon**: `Icons.swap_horiz` (Material Icons)
- **Business Icon**: `Icons.business` (Material Icons)
- **Check Icon**: `Icons.check_circle` (Material Icons)

### Animations
- **Dialog**: Fade in with scale (300ms)
- **Success/Error**: Slide down from top (250ms)
- **Loading**: Circular spinner with rotation

---

## User Flows

### Flow 1: Switch Organization (Success)
1. User sees current org name in AppBar
2. User taps swap icon (⇄)
3. Dialog appears with org list
4. User taps different organization
5. Dialog closes
6. Loading indicator appears
7. API call completes
8. Loading dismisses
9. Success message shows
10. AppBar updates with new org name

### Flow 2: Switch Organization (Error)
1. User sees current org name in AppBar
2. User taps swap icon (⇄)
3. Dialog appears with org list
4. User taps different organization
5. Dialog closes
6. Loading indicator appears
7. API call fails
8. Loading dismisses
9. Error message shows
10. AppBar remains unchanged

### Flow 3: View Organizations (No Switch)
1. User sees current org name in AppBar
2. User taps swap icon (⇄)
3. Dialog appears with org list
4. User reviews organizations
5. User taps "Cancel"
6. Dialog closes
7. No changes made

---

## Accessibility

### Screen Reader Support
- Swap icon: "Switch Organization"
- Current organization: "Veterans United, current organization"
- Other organizations: "[Name], tap to switch"
- Loading: "Switching organization, please wait"

### Keyboard Navigation
- Tab through organizations
- Enter to select
- Escape to cancel

### Color Contrast
- All text meets WCAG AA standards
- Icons have sufficient contrast
- Interactive elements clearly distinguished

---

## Responsive Design

### Phone (Portrait)
- Full width dialog
- Single column layout
- Touch targets: 48x48px minimum

### Tablet (Landscape)
- Centered dialog (max 400px width)
- Same layout as phone
- Larger touch targets: 56x56px

---

## Edge Cases Handled

1. **No Organizations**: Button hidden
2. **Single Organization**: Button hidden
3. **Network Error**: Error message shown
4. **Invalid Organization**: Error message shown
5. **Dialog Dismissed Early**: Safe navigation with canPop()
6. **Rapid Taps**: Loading state prevents duplicate calls
7. **Token Expired**: API returns 401, handled gracefully

---

## Conclusion

The organization switching UI provides a clean, intuitive interface that:
- ✅ Is only visible when relevant (multiple orgs)
- ✅ Clearly shows current organization
- ✅ Provides immediate feedback
- ✅ Handles errors gracefully
- ✅ Follows Material Design guidelines
- ✅ Meets accessibility standards
