# Soccer Match History - Quick Reference

## 🚀 Quick Start

### For Developers

#### Files to Know
```
lib/
├── models/
│   └── soccer_match.dart          # Enhanced with team names & scores
├── screens/
│   ├── soccer_statistics_screen.dart    # Main stats + FAB
│   └── soccer_match_history_screen.dart # History list + detail view
└── 
test/
├── models/
│   └── soccer_match_test.dart     # Model tests
├── soccer_statistics_screen_test.dart   # Main screen tests
└── soccer_match_history_screen_test.dart # History tests
```

#### Key Components

**1. SoccerMatch Model** (lib/models/soccer_match.dart)
```dart
class SoccerMatch {
  final String matchDay;
  final String homeTeam;      // NEW
  final String awayTeam;      // NEW
  final int homeScore;        // NEW
  final int awayScore;        // NEW
  final String referee;
  final String assistantReferee1;
  final String assistantReferee2;
  final List<MatchGoal> goals;
  final List<MatchAssist> assists;
  final List<MatchCard> yellowCards;
  final List<MatchCard> redCards;
}
```

**2. Main Statistics Screen** (lib/screens/soccer_statistics_screen.dart)
```dart
// Floating Action Button
floatingActionButton: FloatingActionButton.extended(
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SoccerMatchHistoryScreen(),
      ),
    );
  },
  icon: const Icon(Icons.history),
  label: const Text('Match History'),
)

// Score Card
_buildScoreCard() {
  // Displays: HomeTeam Score - Score AwayTeam
}
```

**3. Match History Screen** (lib/screens/soccer_match_history_screen.dart)
```dart
class SoccerMatchHistoryScreen extends StatelessWidget {
  // List of 5 previous matches
  static const List<SoccerMatch> _previousMatches = [...];
  
  @override
  Widget build(BuildContext context) {
    return ListView.builder(...);
  }
}

class SoccerStatisticsDetailScreen extends StatelessWidget {
  final SoccerMatch match;
  // Shows full details for selected match
}
```

## 🎯 Usage Examples

### How to Add More Matches
```dart
// In lib/screens/soccer_match_history_screen.dart
// Add to _previousMatches list:

SoccerMatch(
  matchDay: 'Your Date',
  homeTeam: 'Team A',
  awayTeam: 'Team B',
  homeScore: 2,
  awayScore: 1,
  referee: 'Referee Name',
  assistantReferee1: 'Assistant 1',
  assistantReferee2: 'Assistant 2',
  goals: [...],
  assists: [...],
  yellowCards: [...],
  redCards: [...],
),
```

### How to Navigate to History
```dart
// From any screen:
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => const SoccerMatchHistoryScreen(),
  ),
);
```

### How to Show Match Details
```dart
// Pass a match object:
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => SoccerStatisticsDetailScreen(
      match: yourMatchObject,
    ),
  ),
);
```

## 🧪 Testing

### Run All Tests
```bash
flutter test
```

### Run Specific Tests
```bash
flutter test test/soccer_match_history_screen_test.dart
flutter test test/soccer_statistics_screen_test.dart
flutter test test/models/soccer_match_test.dart
```

### Run Tests with Coverage
```bash
flutter test --coverage
```

## 🎨 UI Elements

### Icons Used
- `Icons.history` - Floating action button
- `Icons.calendar_today` - Match dates
- `Icons.sports_soccer` - Goals
- `Icons.warning` - Yellow cards
- `Icons.cancel` - Red cards
- `Icons.sports` - Referee
- `Icons.assistant_photo` - Assistant referees

### Colors
- **Blue** - Scores, primary actions
- **Green** - Goals
- **Yellow** - Yellow cards
- **Red** - Red cards
- **Orange** - Match officials
- **Grey** - Metadata, dates

## 📱 Screen Navigation

```
App Structure:
└── More Tab (Bottom Navigation)
    └── Soccer Statistics Menu Item
        └── Soccer Statistics Screen
            ├── [Current match display]
            └── [Match History FAB] ──┐
                                      │
        ┌─────────────────────────────┘
        │
        └─→ Match History Screen
            ├── Match Card 1 ──→ Detail Screen
            ├── Match Card 2 ──→ Detail Screen
            ├── Match Card 3 ──→ Detail Screen
            ├── Match Card 4 ──→ Detail Screen
            └── Match Card 5 ──→ Detail Screen
```

## 🔧 Common Tasks

### Change Number of Matches Displayed
Edit `_previousMatches` list in `soccer_match_history_screen.dart`

### Modify Score Card Layout
Edit `_buildScoreCard()` method in respective screen files

### Update Match Statistics
Edit the goals, assists, yellowCards, redCards lists in match objects

### Change Button Text
Edit the `label` parameter in `FloatingActionButton.extended`

### Customize Colors
Modify `iconColor` parameters in `_buildStatCard()` and similar methods

## 📊 Data Structure Quick Reference

```dart
// A complete match example:
const SoccerMatch(
  matchDay: 'Saturday, February 10, 2026',
  homeTeam: 'Veterans United FC',
  awayTeam: 'City Rovers',
  homeScore: 3,
  awayScore: 1,
  referee: 'John Smith',
  assistantReferee1: 'Mike Johnson',
  assistantReferee2: 'Sarah Williams',
  goals: [
    MatchGoal(playerName: 'Player A', minute: '23\'', team: 'Home'),
  ],
  assists: [
    MatchAssist(playerName: 'Player B', minute: '23\'', team: 'Home'),
  ],
  yellowCards: [
    MatchCard(
      playerName: 'Player C',
      minute: '31\'',
      team: 'Away',
      reason: 'Unsporting behavior',
    ),
  ],
  redCards: [],
)
```

## 🐛 Troubleshooting

### Issue: FloatingActionButton not visible
**Solution:** Check that it's defined in the Scaffold widget, not inside the body

### Issue: Navigation not working
**Solution:** Ensure MaterialApp wraps your widget tree and context is valid

### Issue: Tests failing after model changes
**Solution:** Update test data to include new required fields (homeTeam, awayTeam, homeScore, awayScore)

### Issue: Match cards not showing
**Solution:** Verify ListView.builder itemCount matches list length

## 📚 Documentation Links

- [Implementation Guide](SOCCER_MATCH_HISTORY_IMPLEMENTATION.md)
- [Visual Reference](SOCCER_MATCH_HISTORY_VISUAL.md)
- [Final Summary](FINAL_SUMMARY.md)

## 🔗 Related Files

### Models
- `lib/models/soccer_match.dart`

### Screens
- `lib/screens/soccer_statistics_screen.dart`
- `lib/screens/soccer_match_history_screen.dart`
- `lib/screens/tab_screens/more_tab.dart` (menu integration)

### Tests
- `test/models/soccer_match_test.dart`
- `test/soccer_statistics_screen_test.dart`
- `test/soccer_match_history_screen_test.dart`
- `test/more_tab_test.dart`

## ✅ Checklist for Changes

When modifying this feature:
- [ ] Update model if data structure changes
- [ ] Update tests to match changes
- [ ] Run `flutter test` to verify
- [ ] Check UI on different screen sizes
- [ ] Update documentation if needed
- [ ] Verify navigation still works
- [ ] Check accessibility

## 🎓 Best Practices

1. **Use const constructors** - Better performance
2. **Keep widgets small** - Easier to maintain
3. **Test everything** - Catch bugs early
4. **Follow Material Design** - Consistent UX
5. **Document changes** - Help future developers

## 🚀 Performance Tips

- Sample data is `const` for zero runtime overhead
- ListView.builder used for efficient scrolling
- Cards are lightweight widgets
- No unnecessary rebuilds
- Minimal widget tree depth

## 📝 Notes

- This feature uses static sample data
- No backend integration yet
- No data persistence
- Perfect for demonstration and testing
- Ready for backend integration later

---

**Last Updated:** February 11, 2026
**Version:** 1.0.0
**Status:** Production Ready ✅
