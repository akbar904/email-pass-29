
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:com.example.simple_app/cubits/login_cubit.dart';
import 'package:com.example.simple_app/widgets/custom_button.dart';

class LoginScreen extends StatelessWidget {
	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(
				title: Text('Login'),
			),
			body: BlocConsumer<LoginCubit, LoginState>(
				listener: (context, state) {
					if (state is LoginFailure) {
						ScaffoldMessenger.of(context).showSnackBar(
							SnackBar(
								content: Text(state.error),
							),
						);
					}
				},
				builder: (context, state) {
					if (state is LoginLoading) {
						return Center(
							child: CircularProgressIndicator(),
						);
					}
					return Padding(
						padding: const EdgeInsets.all(16.0),
						child: Column(
							mainAxisAlignment: MainAxisAlignment.center,
							children: [
								TextField(
									key: ValueKey('emailField'),
									decoration: InputDecoration(
										labelText: 'Email',
									),
								),
								TextField(
									key: ValueKey('passwordField'),
									decoration: InputDecoration(
										labelText: 'Password',
									),
									obscureText: true,
								),
								SizedBox(height: 20),
								CustomButton(
									text: 'Login',
									onPressed: () {
										final email = (context as Element).findAncestorWidgetOfExactType<TextField>()?.controller?.text ?? '';
										final password = (context as Element).findAncestorWidgetOfExactType<TextField>()?.controller?.text ?? '';
										context.read<LoginCubit>().login(email, password);
									},
								),
							],
						),
					);
				},
			),
		);
	}
}
