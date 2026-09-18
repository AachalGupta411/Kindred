import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:multi_screen_app/main.dart';

void main() {
  Future<void> pumpApp(WidgetTester tester) async {
    await tester.binding.setSurfaceSize(const Size(400, 900));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(const KindredApp());
  }

  Future<void> openForm(WidgetTester tester) async {
    await tester.tap(find.text('Become a member'));
    await tester.pumpAndSettle();
  }

  Future<void> revealFormFooter(WidgetTester tester) async {
    await tester.drag(
      find.byKey(const Key('registration-form')),
      const Offset(0, -1200),
    );
    await tester.pumpAndSettle();
  }

  testWidgets('home screen opens the registration form', (tester) async {
    await pumpApp(tester);

    expect(find.text('Become a member'), findsOneWidget);
    await openForm(tester);

    expect(find.text('Full name'), findsOneWidget);
    expect(find.text('Email address'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);
  });

  testWidgets('registration form validates required fields', (tester) async {
    await pumpApp(tester);
    await openForm(tester);
    await revealFormFooter(tester);

    await tester.tap(find.text('Request membership'));
    await tester.pumpAndSettle();

    expect(find.text('Name is required'), findsOneWidget);
    expect(find.text('Email is required'), findsOneWidget);
    expect(find.text('Password is required'), findsOneWidget);
    expect(find.text('Required to continue'), findsOneWidget);
  });

  testWidgets('valid registration opens the member card', (tester) async {
    await pumpApp(tester);
    await openForm(tester);

    await tester.enterText(
      find.widgetWithText(TextFormField, 'Full name'),
      'Asha Mehta',
    );
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Email address'),
      'asha@kindred.club',
    );
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Password'),
      'pages123',
    );
    await revealFormFooter(tester);
    await tester.tap(find.byType(CheckboxListTile));
    await tester.tap(find.text('Request membership'));
    await tester.pumpAndSettle();

    expect(find.textContaining('You’re in'), findsOneWidget);
    expect(find.text('asha@kindred.club'), findsOneWidget);
    expect(find.text('Reader'), findsOneWidget);
  });
}
