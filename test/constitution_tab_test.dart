import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:veteranapp/screens/tab_screens/constitution_tab.dart';
import 'package:veteranapp/providers/user_provider.dart';
import 'package:veteranapp/models/user.dart';
import 'package:veteranapp/models/organization.dart';

void main() {
  // Helper to create test user with organization
  User createTestUser() {
    return User(
      id: 'test-id',
      username: 'testuser',
      email: 'test@example.com',
      name: 'Test User',
      organizations: [
        Organization(
          id: 'org1',
          name: 'Veterans Organization',
          location: 'Test City',
        ),
      ],
      currentOrganizationId: 'org1',
    );
  }

  // Helper to wrap widget with Provider
  Widget wrapWithProvider(Widget child, {User? user}) {
    final userProvider = UserProvider();
    if (user != null) {
      userProvider.setUser(user);
    }
    return ChangeNotifierProvider<UserProvider>.value(
      value: userProvider,
      child: MaterialApp(
        home: child,
      ),
    );
  }

  testWidgets('Constitution tab displays correctly', (WidgetTester tester) async {
    await tester.pumpWidget(
      wrapWithProvider(const ConstitutionTab(), user: createTestUser()),
    );

    // Wait for async data loading
    await tester.pumpAndSettle();

    // Verify the app bar title is displayed
    expect(find.text('Constitution'), findsOneWidget);
    
    // Verify the organization name is displayed
    expect(find.text('Veterans Organization'), findsOneWidget);
    
    // Verify some articles are displayed
    expect(find.text('Article I: Name and Purpose'), findsOneWidget);
    expect(find.text('Article II: Membership'), findsOneWidget);
  });

  testWidgets('Constitution tab displays share buttons for articles', (WidgetTester tester) async {
    await tester.pumpWidget(
      wrapWithProvider(const ConstitutionTab(), user: createTestUser()),
    );

    // Wait for async data loading
    await tester.pumpAndSettle();

    // Verify share icons are present
    expect(find.byIcon(Icons.share), findsWidgets);
    
    // Should have 11 articles, so 11 share buttons
    final shareButtons = find.byIcon(Icons.share);
    expect(shareButtons, findsNWidgets(11));
  });

  testWidgets('Constitution tab share buttons have correct tooltip', (WidgetTester tester) async {
    await tester.pumpWidget(
      wrapWithProvider(const ConstitutionTab(), user: createTestUser()),
    );

    // Wait for async data loading
    await tester.pumpAndSettle();

    // Find all share buttons
    final shareButtons = find.byIcon(Icons.share);
    
    // Get the first share button
    final firstShareButton = shareButtons.first;
    
    // Verify tooltip exists
    expect(find.byTooltip('Share Article'), findsWidgets);
  });

  testWidgets('Constitution tab displays all 11 articles', (WidgetTester tester) async {
    await tester.pumpWidget(
      wrapWithProvider(const ConstitutionTab(), user: createTestUser()),
    );

    // Wait for async data loading
    await tester.pumpAndSettle();
    
    // Verify all article titles are present
    final articles = [
      'Article I: Name and Purpose',
      'Article II: Membership',
      'Article III: Rights and Responsibilities',
      'Article IV: Officers and Executive Board',
      'Article V: Duties of Officers',
      'Article VI: Meetings',
      'Article VII: Committees',
      'Article VIII: Finances',
      'Article IX: Amendments',
      'Article X: Dissolution',
      'Article XI: Parliamentary Authority',
    ];

    for (final article in articles) {
      await tester.dragUntilVisible(
        find.text(article),
        find.byType(SingleChildScrollView),
        const Offset(0, -50),
      );
      expect(find.text(article), findsOneWidget);
    }
  });

  testWidgets('Constitution tab displays ratification notice', (WidgetTester tester) async {
    await tester.pumpWidget(
      wrapWithProvider(const ConstitutionTab(), user: createTestUser()),
    );

    // Wait for async data loading
    await tester.pumpAndSettle();

    // Scroll to bottom to find the ratification notice
    await tester.drag(find.byType(SingleChildScrollView), const Offset(0, -5000));
    await tester.pumpAndSettle();

    // Verify the ratification card is displayed
    expect(find.text('This constitution was adopted and ratified by the membership.'), findsOneWidget);
    expect(find.byIcon(Icons.check_circle), findsOneWidget);
  });
}
