# Soccer Match History - Visual Reference

## Screen Flow Diagram

```
┌─────────────────────────────────┐
│        More Tab                 │
│  (Bottom Navigation)            │
│                                 │
│  • Profile                      │
│  • Activity Statistics          │
│  ► Soccer Statistics ◄────────┐ │
│  • Settings                    │ │
│  • Notifications               │ │
│  • Members Hosting             │ │
│  • Help & Support              │ │
│  • About                       │ │
└─────────────────────────────────┘ │
                                    │
                                    │ User taps
                                    ▼
┌─────────────────────────────────────────────┐
│    Soccer Statistics Screen                 │
│                                             │
│  ┌───────────────────────────────────────┐ │
│  │ Match Information                     │ │
│  │ 📅 Saturday, February 10, 2026        │ │
│  └───────────────────────────────────────┘ │
│                                             │
│  ┌───────────────────────────────────────┐ │
│  │  Veterans United FC      3            │ │ User sees current match
│  │           -                           │ │ statistics
│  │     City Rovers          1            │ │
│  └───────────────────────────────────────┘ │
│                                             │
│  Match Officials                            │
│  👤 Referee: John Smith                     │
│  👥 Assistant 1: Mike Johnson               │
│  👥 Assistant 2: Sarah Williams             │
│                                             │
│  Goals (4), Assists (4),                    │
│  Yellow Cards (3), Red Cards (1)            │
│  [Full statistics details...]               │
│                                             │
│                      ┌─────────────────┐    │
│                      │ 📜 Match History │    │ ◄── New Floating Button!
│                      └─────────────────┘    │
└─────────────────────────────────────────────┘
                            │
                            │ User taps
                            ▼
┌──────────────────────────────────────────────────┐
│    Match History Screen                          │
│                                                  │
│  ┌────────────────────────────────────────────┐ │
│  │ 📅 Saturday, February 10, 2026             │ │
│  │                                            │ │
│  │    Veterans United FC        3             │ │
│  │              -                             │ │
│  │       City Rovers            1             │ │
│  │ ──────────────────────────────────────     │ │ ◄── Each match is tappable
│  │   ⚽ 4      ⚠️ 3      🚫 1                 │ │
│  └────────────────────────────────────────────┘ │
│                                                  │
│  ┌────────────────────────────────────────────┐ │
│  │ 📅 Saturday, February 3, 2026              │ │
│  │    Veterans United FC        2             │ │
│  │              -                             │ │
│  │       Rangers FC             2             │ │
│  │ ──────────────────────────────────────     │ │
│  │   ⚽ 4      ⚠️ 2      🚫 0                 │ │
│  └────────────────────────────────────────────┘ │
│                                                  │
│  ┌────────────────────────────────────────────┐ │
│  │ 📅 Saturday, January 27, 2026              │ │
│  │    Thunder United            1             │ │
│  │              -                             │ │
│  │  Veterans United FC          4             │ │
│  │ ──────────────────────────────────────     │ │
│  │   ⚽ 5      ⚠️ 1      🚫 0                 │ │
│  └────────────────────────────────────────────┘ │
│                                                  │
│  [2 more matches...]                            │
│                                                  │
└──────────────────────────────────────────────────┘
                      │
                      │ User taps any match
                      ▼
┌─────────────────────────────────────────────┐
│    Match Details Screen                     │
│                                             │
│  ┌───────────────────────────────────────┐ │
│  │ Match Information                     │ │
│  │ 📅 Saturday, February 3, 2026         │ │
│  └───────────────────────────────────────┘ │
│                                             │
│  ┌───────────────────────────────────────┐ │
│  │  Veterans United FC      2            │ │
│  │           -                           │ │
│  │     Rangers FC           2            │ │
│  └───────────────────────────────────────┘ │
│                                             │
│  Match Officials                            │
│  [Full details for selected match...]      │
│                                             │
│  Goals, Assists, Cards                      │
│  [Complete statistics...]                   │
│                                             │
└─────────────────────────────────────────────┘
```

## Key UI Elements

### 1. Floating Action Button (Soccer Statistics Screen)
- **Icon:** 📜 History icon
- **Label:** "Match History"
- **Position:** Bottom right (Material Design standard)
- **Color:** Primary theme color (blue)
- **Type:** FloatingActionButton.extended

### 2. Score Card
- **Layout:** Two-column display
- **Elements:**
  - Team names (centered, bold)
  - Scores (large, blue, bold)
  - Dash separator
- **Styling:** Card with elevation 2

### 3. Match History Card
- **Header:** Date with calendar icon
- **Body:** Score display (same as score card)
- **Footer:** Quick stats with icons
  - ⚽ Goals count (green)
  - ⚠️ Yellow cards count (yellow)
  - 🚫 Red cards count (red)
- **Interaction:** Tappable (InkWell)
- **Styling:** Card with elevation 2, margin bottom 16

### 4. Statistics Summary Icons
- **Goals:** `Icons.sports_soccer` (green)
- **Yellow Cards:** `Icons.warning` (yellow/amber)
- **Red Cards:** `Icons.cancel` (red)

## Data Structure

### SoccerMatch Model (Enhanced)
```dart
class SoccerMatch {
  final String matchDay;        // "Saturday, February 10, 2026"
  final String homeTeam;        // NEW: "Veterans United FC"
  final String awayTeam;        // NEW: "City Rovers"
  final int homeScore;          // NEW: 3
  final int awayScore;          // NEW: 1
  final String referee;
  final String assistantReferee1;
  final String assistantReferee2;
  final List<MatchGoal> goals;
  final List<MatchAssist> assists;
  final List<MatchCard> yellowCards;
  final List<MatchCard> redCards;
}
```

## Sample Match Data Summary

| Date | Match | Score | Goals | Yellow | Red |
|------|-------|-------|-------|--------|-----|
| Feb 10 | Veterans United vs City Rovers | 3-1 | 4 | 3 | 1 |
| Feb 3 | Veterans United vs Rangers FC | 2-2 | 4 | 2 | 0 |
| Jan 27 | Thunder United vs Veterans United | 1-4 | 5 | 1 | 0 |
| Jan 20 | Veterans United vs Eagles FC | 1-0 | 1 | 2 | 0 |
| Jan 13 | Wildcats FC vs Veterans United | 3-3 | 6 | 2 | 1 |

## Color Scheme

### Icons
- 📅 Calendar: Grey
- ⚽ Goals: Green (`Colors.green`)
- 👤 Referee: Orange (`Colors.orange`)
- 👥 Assistants: Orange (`Colors.orange`)
- ⚠️ Yellow Cards: Yellow (`Colors.yellow.shade700`)
- 🚫 Red Cards: Red (`Colors.red`)
- 📜 History: White (on primary blue button)

### Text
- **Headers:** Black, bold, size 20
- **Team Names:** Black, bold, size 16
- **Scores:** Blue, bold, size 32 (details) or 24 (list)
- **Metadata:** Grey, size 14
- **Reasons:** Grey, italic, size 13

### Cards
- **Elevation:** 2
- **Background:** White (Material default)
- **Margin:** Horizontal 16, varies vertically

## Navigation Flow

```
More Tab
   │
   ├─► Soccer Statistics (Main Screen)
   │      │
   │      └─► Match History (List Screen)
   │             │
   │             └─► Match Details (Detail Screen)
   │
   └─► [Other menu items...]
```

## Screen Transitions

All transitions use standard Material `Navigator.push` with `MaterialPageRoute`:
- Smooth slide-in animation
- Standard back button behavior
- Maintains navigation stack

## Accessibility Features

- All interactive elements are tappable (minimum 48x48 dp)
- Icons have semantic meaning
- Text is readable (minimum size 13)
- Color is not the only indicator (icons + text)
- Cards have sufficient contrast (elevation)

## Responsive Design

- Scrollable lists for any number of matches
- Score display adapts to team name length (Expanded widget)
- Cards stretch to screen width (minus padding)
- Works on any screen size (portrait/landscape)

## Performance Considerations

- Const constructors where possible
- Static sample data (no network calls)
- Efficient list rendering (ListView.builder)
- Minimal widget rebuilds
- Card elevation for depth perception

## Testing Coverage

✅ Unit tests for models
✅ Widget tests for all screens
✅ Navigation tests
✅ UI element presence tests
✅ Data display tests
✅ Interaction tests

## Future UI Enhancements

Ideas for future iterations:
- Pull-to-refresh for data updates
- Animated transitions
- Swipe gestures
- Filters and search UI
- Share button
- Favorite matches
- Match highlights carousel
- Player profiles
- Team logos
