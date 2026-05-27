import 'package:flutter_bloc/flutter_bloc.dart';
import 'home_event.dart';
import 'home_state.dart';
import '../../data/repositories/user_repo.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final UserRepository userRepository;

  HomeBloc({required this.userRepository}) : super(HomeInitial()) {
    on<SubmitSaypienForm>(_onSubmitSaypienForm);
  }

  Future<void> _onSubmitSaypienForm(
      SubmitSaypienForm event,
      Emitter<HomeState> emit,
      ) async {
    emit(HomeFormLoading());
    try {
      await userRepository.addSaypien(event.user);
      emit(HomeFormSuccess());
      await Future.delayed(const Duration(seconds: 2));
      emit(HomeInitial());
    } catch (e) {
      emit(HomeFormError(e.toString()));
      await Future.delayed(const Duration(seconds: 3));
      emit(HomeInitial());
    }
  }
}