
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:com.example.simple_app/lib/cubits/home_cubit.dart';

class MockHomeCubit extends MockCubit<HomeState> implements HomeCubit {}

void main() {
	group('HomeCubit', () {
		late HomeCubit homeCubit;

		setUp(() {
			homeCubit = MockHomeCubit();
		});

		test('initial state is HomeInitial', () {
			expect(homeCubit.state, equals(HomeInitial()));
		});

		blocTest<HomeCubit, HomeState>(
			'emits [HomeLoggedOut] when logout is called',
			build: () => homeCubit,
			act: (cubit) => cubit.logout(),
			expect: () => [HomeLoggedOut()],
		);
	});
}
