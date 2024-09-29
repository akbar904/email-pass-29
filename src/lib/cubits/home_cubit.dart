
import 'package:flutter_bloc/flutter_bloc.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
	HomeCubit() : super(HomeInitial());

	void logout() {
		emit(HomeLoggedOut());
	}
}

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoggedOut extends HomeState {}
