
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:com.example.simple_app/screens/home_screen.dart';
import 'package:com.example.simple_app/cubits/home_cubit.dart';
import 'package:com.example.simple_app/cubits/home_state.dart';

class MockHomeCubit extends MockCubit<HomeState> implements HomeCubit {}

void main() {
	group('HomeScreen', () {
		late HomeCubit homeCubit;

		setUp(() {
			homeCubit = MockHomeCubit();
		});

		tearDown(() {
			homeCubit.close();
		});

		group('UI Elements', () {
			testWidgets('renders a logout button', (WidgetTester tester) async {
				await tester.pumpWidget(
					MaterialApp(
						home: HomeScreen(),
					),
				);

				expect(find.text('Logout'), findsOneWidget);
				expect(find.byType(ElevatedButton), findsOneWidget);
			});
		});

		group('Cubit Interactions', () {
			blocTest<MockHomeCubit, HomeState>(
				'emits LoggedOut state when logout is called',
				build: () => homeCubit,
				act: (cubit) => cubit.logout(),
				expect: () => [LoggedOut()],
			);

			testWidgets('calls logout when logout button is pressed', (WidgetTester tester) async {
				when(() => homeCubit.logout()).thenAnswer((_) async {});

				await tester.pumpWidget(
					MaterialApp(
						home: BlocProvider.value(
							value: homeCubit,
							child: HomeScreen(),
						),
					),
				);

				await tester.tap(find.text('Logout'));
				await tester.pump();

				verify(() => homeCubit.logout()).called(1);
			});
		});
	});
}
