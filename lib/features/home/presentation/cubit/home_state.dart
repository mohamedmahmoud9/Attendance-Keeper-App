part of 'home_cubit.dart';

abstract class StartWorkState extends Equatable {
  const StartWorkState();

  @override
  List<Object> get props => [];
}

class StartWorkInitial extends StartWorkState {}

class StartWorkLoading extends StartWorkState {}

class StartWorkSuccess extends StartWorkState {}

class StartWorkFailure extends StartWorkState {
  final String message;
  const StartWorkFailure({required this.message});
}
