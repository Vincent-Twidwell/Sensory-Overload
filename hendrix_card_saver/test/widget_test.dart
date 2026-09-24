// Hendrix Card Saver — app widget tests
//


import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
 
import 'package:hendrix_card_saver/main.dart';
import 'package:hendrix_card_saver/screens/home_screen.dart';
import 'package:hendrix_card_saver/theme/app_theme.dart';
import 'package:hendrix_card_saver/widgets/saved_card.dart';

void main() {
  testWidgets('app builds with the expected title, theme, and home screen',
      (tester) async {
    await tester.pumpWidget(const HendrixCardSaverApp());
 
    final materialApp = tester.widget<MaterialApp>(find.byType(MaterialApp));
 
    expect(materialApp.title, 'Card Saver App');
    expect(materialApp.debugShowCheckedModeBanner, isFalse);
    expect(materialApp.theme, AppTheme.lightTheme);
    expect(find.byType(HomeScreen), findsOneWidget);
  });

  testWidgets('launches straight to the dashboard without a network call',
      (tester) async {
    // the app should launch and display locally stored cards without
    // needing an internet connection.
    await tester.pumpWidget(const HendrixCardSaverApp());
 
    expect(find.text('Hendrix Card Saver'), findsOneWidget);
    expect(find.text('Sample Student'), findsOneWidget);
  });

  Widget wrap(Widget child) {
    return MaterialApp(
      theme: AppTheme.lightTheme,
      home: Scaffold(body: child),
    );
  }
 
  testWidgets('renders the student name and ID', (tester) async {
    await tester.pumpWidget(
      wrap(
        SavedCard(
          studentName: 'Jamie Rivers',
          studentId: '123456789',
          onTap: () {},
        ),
      ),
    );
  
    expect(find.text('Jamie Rivers'), findsOneWidget);
    expect(find.text('Student ID  123456789'), findsOneWidget);
  });

  testWidgets('shows the school icon and chevron affordance', (tester) async {
    await tester.pumpWidget(
      wrap(
        SavedCard(
          studentName: 'Jamie Rivers',
          studentId: '123456789',
          onTap: () {},
        ),
      ),
    );
    expect(find.byIcon(Icons.school_outlined), findsOneWidget);
    expect(find.byIcon(Icons.chevron_right), findsOneWidget);
  });

  testWidgets('calls onTap exactly once when tapped', (tester) async {
    var tapCount = 0;
 
    await tester.pumpWidget(
      wrap(
        SavedCard(
          studentName: 'Jamie Rivers',
          studentId: '123456789',
          onTap: () => tapCount++,
        ),
      ),
    );
 
    await tester.tap(find.byKey(const Key('savedCard')));
    await tester.pump();
 
    expect(tapCount, 1);
  });

    testWidgets('updates displayed text when a different card is passed',
      (tester) async {
    await tester.pumpWidget(
      wrap(
        SavedCard(
          studentName: 'Sample Student',
          studentId: '000000000',
          onTap: () {},
        ),
      ),
    );
 
    expect(find.text('Sample Student'), findsOneWidget);
 
    await tester.pumpWidget(
      wrap(
        SavedCard(
          studentName: 'Taylor Banks',
          studentId: '987654321',
          onTap: () {},
        ),
      ),
    );
    expect(find.text('Sample Student'), findsNothing);
    expect(find.text('Taylor Banks'), findsOneWidget);
    expect(find.text('Student ID  987654321'), findsOneWidget);
  });

testWidgets('shows the sample saved card on the dashboard', (tester) async {
    await tester.pumpWidget(wrap(const HomeScreen()));
 
    expect(find.text('Sample Student'), findsOneWidget);
    expect(find.text('Student ID  000000000'), findsOneWidget);
    expect(find.byKey(const Key('savedCard')), findsOneWidget);
  });

    testWidgets('calls onScanCard when the scan button is tapped',
      (tester) async {
    var scanCount = 0;
 
    await tester.pumpWidget(
      wrap(HomeScreen(onScanCard: () => scanCount++)),
    );
 
    await tester.tap(find.byKey(const Key('scanCardButton')));
    await tester.pump();
 
    expect(scanCount, 1);
  });

  testWidgets('calls onOpenCard when the saved card is tapped',
      (tester) async {
    var openCount = 0;
 
    await tester.pumpWidget(
      wrap(HomeScreen(onOpenCard: () => openCount++)),
    );
 
    await tester.tap(find.byKey(const Key('savedCard')));
    await tester.pump();
 
    expect(openCount, 1);
  });


}