
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:simple_app/models/user.dart';

void main() {
	group('User Model', () {
		test('User model should serialize from JSON', () {
			final json = {'email': 'test@example.com', 'password': 'password123'};
			final user = User.fromJson(json);

			expect(user.email, 'test@example.com');
			expect(user.password, 'password123');
		});

		test('User model should serialize to JSON', () {
			final user = User(email: 'test@example.com', password: 'password123');
			final json = user.toJson();

			expect(json['email'], 'test@example.com');
			expect(json['password'], 'password123');
		});
	});
}
