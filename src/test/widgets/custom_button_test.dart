
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:com.example.simple_app/widgets/custom_button.dart';

void main() {
	group('CustomButton Widget Tests', () {
		testWidgets('renders with given text', (WidgetTester tester) async {
			// Arrange
			const String buttonText = 'Custom Button';
			
			// Act
			await tester.pumpWidget(
				const MaterialApp(
					home: Scaffold(
						body: CustomButton(
							text: buttonText,
							onPressed: null,
						),
					),
				),
			);
			
			// Assert
			expect(find.text(buttonText), findsOneWidget);
		});

		testWidgets('triggers onPressed callback when tapped', (WidgetTester tester) async {
			// Arrange
			bool pressed = false;
			const String buttonText = 'Custom Button';

			// Act
			await tester.pumpWidget(
				MaterialApp(
					home: Scaffold(
						body: CustomButton(
							text: buttonText,
							onPressed: () {
								pressed = true;
							},
						),
					),
				),
			);
			
			await tester.tap(find.text(buttonText));
			await tester.pumpAndSettle();

			// Assert
			expect(pressed, isTrue);
		});

		testWidgets('is disabled when onPressed is null', (WidgetTester tester) async {
			// Arrange
			const String buttonText = 'Custom Button';

			// Act
			await tester.pumpWidget(
				const MaterialApp(
					home: Scaffold(
						body: CustomButton(
							text: buttonText,
							onPressed: null,
						),
					),
				),
			);
			
			final Finder buttonFinder = find.byType(CustomButton);

			// Assert
			expect(tester.widget<ElevatedButton>(buttonFinder).enabled, isFalse);
		});
	});
}
