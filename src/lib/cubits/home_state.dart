
import 'package:flutter_bloc/flutter_bloc.dart';

// Define the abstract base class for HomeState
abstract class HomeState {}

// Define the specific states
class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {}

class HomeLoggedOut extends HomeState {}

// Define the HomeCubit class
class HomeCubit extends Cubit<HomeState> {
	HomeCubit() : super(HomeInitial());

	void loadHomeScreen() {
		emit(HomeLoading());
		// Simulate some delay or API call
		emit(HomeLoaded());
	}

	void logout() {
		emit(HomeLoading());
		// Simulate the logout process
		emit(HomeLoggedOut());
	}
}
