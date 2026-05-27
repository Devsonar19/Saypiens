import 'package:equatable/equatable.dart';
import '../../data/models/user_model.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class SubmitSaypienForm extends HomeEvent {
  final SaypienUserModel user;

  const SubmitSaypienForm(this.user);

  @override
  List<Object> get props => [user];
}