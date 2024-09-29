
import 'package:flutter_bloc/flutter_bloc.dart';
import 'login_state.dart';
import '../models/user.dart';

class LoginCubit extends Cubit<LoginState> {
	LoginCubit() : super(LoginInitial());

	void login(String email, String password) async {
		emit(LoginLoading());
		try {
			// Simulate a delay for login process
			await Future.delayed(Duration(seconds: 1));
			// Assuming the correct credentials are email: 'test@example.com' and password: 'password'
			if (email == 'test@example.com' && password == 'password') {
				emit(LoginSuccess());
			} else {
				emit(LoginFailure('Invalid credentials'));
			}
		} catch (e) {
			emit(LoginFailure('Something went wrong'));
		}
	}
}
