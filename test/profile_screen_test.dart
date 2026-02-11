import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:veteranapp/screens/profile_screen.dart';

void main() {
  testWidgets('Profile screen displays correctly', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: ProfileScreen(),
      ),
    );

    // Verify that the screen title is displayed
    expect(find.text('Profile'), findsOneWidget);
    
    // Verify user information
    expect(find.text('John Doe'), findsOneWidget);
    expect(find.text('Member'), findsOneWidget);
    
    // Verify section headers
    expect(find.text('Contact Information'), findsOneWidget);
    expect(find.text('Military Service'), findsOneWidget);
    expect(find.text('Membership'), findsOneWidget);
    
    // Verify contact information
    expect(find.text('Email'), findsOneWidget);
    expect(find.text('john.doe@example.com'), findsOneWidget);
    expect(find.text('Phone'), findsOneWidget);
    expect(find.text('+1 (555) 123-4567'), findsOneWidget);
    
    // Verify military service information
    expect(find.text('Service Branch'), findsOneWidget);
    expect(find.text('United States Army'), findsOneWidget);
    expect(find.text('Years of Service'), findsOneWidget);
    expect(find.text('2010 - 2020'), findsOneWidget);
    
    // Verify membership information
    expect(find.text('Status'), findsOneWidget);
    expect(find.text('Active Member'), findsOneWidget);
    expect(find.text('Member Since'), findsOneWidget);
    expect(find.text('January 2021'), findsOneWidget);
  });

  testWidgets('Profile screen has edit button', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: ProfileScreen(),
      ),
    );

    // Verify the edit button is displayed
    expect(find.byIcon(Icons.edit), findsOneWidget);
  });

  testWidgets('Profile screen is scrollable', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: ProfileScreen(),
      ),
    );

    // Verify the screen has a SingleChildScrollView
    expect(find.byType(SingleChildScrollView), findsOneWidget);
  });

  testWidgets('Edit button shows coming soon message', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: ProfileScreen(),
      ),
    );

    // Tap the edit button
    await tester.tap(find.byIcon(Icons.edit));
    await tester.pump();

    // Verify the snackbar message is shown
    expect(find.text('Edit profile feature coming soon'), findsOneWidget);
  });

  testWidgets('Profile screen displays user avatar with initials', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: ProfileScreen(),
      ),
    );

    // Verify the avatar displays initials
    expect(find.text('JD'), findsOneWidget);
    expect(find.byType(CircleAvatar), findsOneWidget);
  });

  testWidgets('Profile screen displays all info cards with icons', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: ProfileScreen(),
      ),
    );

    // Verify all icons are displayed
    expect(find.byIcon(Icons.email), findsOneWidget);
    expect(find.byIcon(Icons.phone), findsOneWidget);
    expect(find.byIcon(Icons.military_tech), findsOneWidget);
    expect(find.byIcon(Icons.calendar_today), findsOneWidget);
    expect(find.byIcon(Icons.info), findsOneWidget);
    expect(find.byIcon(Icons.event), findsOneWidget);
  });
}
