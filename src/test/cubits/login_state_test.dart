
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:com.example.simple_app/cubits/login_state.dart';

class MockLoginCubit extends MockCubit<LoginState> implements LoginCubit {}

void main() {
	group('LoginCubit', () {
		late MockLoginCubit loginCubit;

		setUp(() {
			loginCubit = MockLoginCubit();
		});

		blocTest<MockLoginCubit, LoginState>(
			'initial state is LoginInitial',
			build: () => loginCubit,
			verify: (cubit) => expect(cubit.state, equals(LoginInitial())),
		);

		blocTest<MockLoginCubit, LoginState>(
			'emits [LoginLoading, LoginSuccess] when login is successful',
			build: () => loginCubit,
			act: (cubit) {
				when(() => cubit.login(any(), any())).thenAnswer((_) async {
					cubit.emit(LoginLoading());
					await Future.delayed(Duration(milliseconds: 100));
					cubit.emit(LoginSuccess());
				});
				cubit.login('email@example.com', 'password');
			},
			expect: () => [LoginLoading(), LoginSuccess()],
		);

		blocTest<MockLoginCubit, LoginState>(
			'emits [LoginLoading, LoginFailure] when login fails',
			build: () => loginCubit,
			act: (cubit) {
				when(() => cubit.login(any(), any())).thenAnswer((_) async {
					cubit.emit(LoginLoading());
					await Future.delayed(Duration(milliseconds: 100));
					cubit.emit(LoginFailure('Invalid credentials'));
				});
				cubit.login('email@example.com', 'wrongpassword');
			},
			expect: () => [LoginLoading(), LoginFailure('Invalid credentials')],
		);
	});
}
