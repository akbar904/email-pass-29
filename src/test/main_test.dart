
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:com.example.simple_app/main.dart';

void main() {
	group('MainApp Cubit Tests', () {
		// Assuming main.dart has a Cubit for managing global state, initialize it here
		late MainCubit mainCubit;

		setUp(() {
			mainCubit = MainCubit();
		});

		tearDown(() {
			mainCubit.close();
		});

		blocTest<MainCubit, MainState>(
			'Initial state is MainInitial',
			build: () => mainCubit,
			verify: (cubit) => expect(cubit.state, equals(MainInitial())),
		);

		blocTest<MainCubit, MainState>(
			'Emits [MainLoading, MainLoaded] when someAction is successful',
			build: () => mainCubit,
			act: (cubit) => cubit.someAction(),
			expect: () => [MainLoading(), MainLoaded()],
		);
	});

	group('MainApp Widget Tests', () {
		testWidgets('LoginScreen is displayed initially', (WidgetTester tester) async {
			await tester.pumpWidget(MainApp());
			expect(find.text('Login Screen'), findsOneWidget);
		});

		testWidgets('HomeScreen is displayed after login', (WidgetTester tester) async {
			await tester.pumpWidget(MainApp());

			// Simulate login action
			await tester.enterText(find.byKey(Key('emailField')), 'test@example.com');
			await tester.enterText(find.byKey(Key('passwordField')), 'password');
			await tester.tap(find.byKey(Key('loginButton')));
			await tester.pumpAndSettle();

			expect(find.text('Home Screen'), findsOneWidget);
		});

		testWidgets('Logout button navigates back to LoginScreen', (WidgetTester tester) async {
			await tester.pumpWidget(MainApp());

			// Simulate login action
			await tester.enterText(find.byKey(Key('emailField')), 'test@example.com');
			await tester.enterText(find.byKey(Key('passwordField')), 'password');
			await tester.tap(find.byKey(Key('loginButton')));
			await tester.pumpAndSettle();

			// Simulate logout action
			await tester.tap(find.byKey(Key('logoutButton')));
			await tester.pumpAndSettle();

			expect(find.text('Login Screen'), findsOneWidget);
		});
	});
}
