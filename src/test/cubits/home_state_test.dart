
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:com.example.simple_app/cubits/home_state.dart';

class MockHomeCubit extends MockCubit<HomeState> implements HomeCubit {}

void main() {
	group('HomeCubit', () {
		late MockHomeCubit homeCubit;

		setUp(() {
			homeCubit = MockHomeCubit();
		});

		test('initial state is HomeInitial', () {
			expect(homeCubit.state, HomeInitial());
		});

		blocTest<MockHomeCubit, HomeState>(
			'emits [HomeLoading, HomeLoaded] when home screen is loaded',
			build: () => homeCubit,
			act: (cubit) => cubit.loadHomeScreen(),
			expect: () => [HomeLoading(), HomeLoaded()],
		);

		blocTest<MockHomeCubit, HomeState>(
			'emits [HomeLoading, HomeLoggedOut] when logout is invoked',
			build: () => homeCubit,
			act: (cubit) => cubit.logout(),
			expect: () => [HomeLoading(), HomeLoggedOut()],
		);
	});
}
