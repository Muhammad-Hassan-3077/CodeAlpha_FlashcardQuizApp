import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flashcard_quiz_app/main.dart';

void main() {
  testWidgets('Home screen loads with app bar title', (WidgetTester tester) async {
    await tester.pumpWidget(const FlashcardQuizApp());
    await tester.pumpAndSettle();

    expect(find.text('Flashcard Quiz'), findsOneWidget);
  });
}