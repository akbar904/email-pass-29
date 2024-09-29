
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:com.example.simple_app/screens/login_screen.dart';

class MockLoginCubit extends MockCubit<LoginState> implements LoginCubit {}

void main() {
	group('LoginScreen', () {
		late MockLoginCubit mockLoginCubit;

		setUp(() {
			mockLoginCubit = MockLoginCubit();
		});

		testWidgets('should display email and password TextFields', (WidgetTester tester) async {
			await tester.pumpWidget(MaterialApp(home: LoginScreen()));

			expect(find.byType(TextField), findsNWidgets(2));
			expect(find.text('Email'), findsOneWidget);
			expect(find.text('Password'), findsOneWidget);
		});

		testWidgets('should display login button', (WidgetTester tester) async {
			await tester.pumpWidget(MaterialApp(home: LoginScreen()));

			expect(find.byType(CustomButton), findsOneWidget);
			expect(find.text('Login'), findsOneWidget);
		});

		testWidgets('should call login when login button is pressed', (WidgetTester tester) async {
			when(() => mockLoginCubit.state).thenReturn(LoginInitial());
			await tester.pumpWidget(MaterialApp(home: BlocProvider<LoginCubit>.value(value: mockLoginCubit, child: LoginScreen())));

			final emailField = find.byKey(ValueKey('emailField'));
			final passwordField = find.byKey(ValueKey('passwordField'));
			final loginButton = find.text('Login');

			await tester.enterText(emailField, 'test@example.com');
			await tester.enterText(passwordField, 'password123');
			await tester.tap(loginButton);
			await tester.pump();

			verify(() => mockLoginCubit.login('test@example.com', 'password123')).called(1);
		});

		testWidgets('should show loading indicator when state is loading', (WidgetTester tester) async {
			when(() => mockLoginCubit.state).thenReturn(LoginLoading());
			await tester.pumpWidget(MaterialApp(home: BlocProvider<LoginCubit>.value(value: mockLoginCubit, child: LoginScreen())));

			expect(find.byType(CircularProgressIndicator), findsOneWidget);
		});

		testWidgets('should show error message when state is failure', (WidgetTester tester) async {
			const errorMessage = 'Login failed';
			when(() => mockLoginCubit.state).thenReturn(LoginFailure(errorMessage));
			await tester.pumpWidget(MaterialApp(home: BlocProvider<LoginCubit>.value(value: mockLoginCubit, child: LoginScreen())));

			expect(find.text(errorMessage), findsOneWidget);
		});
	});
}
