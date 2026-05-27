import 'package:equatable/equatable.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class HomeFormLoading extends HomeState {}

class HomeFormSuccess extends HomeState {}

class HomeFormError extends HomeState {
  final String message;
  const HomeFormError(this.message);

  @override
  List<Object> get props => [message];
}