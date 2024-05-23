part of 'end_work_cubit.dart';

sealed class EndWorkState extends Equatable {
  const EndWorkState();

  @override
  List<Object> get props => [];
}

final class EndWorkInitial extends EndWorkState {}

final class EndWorkLoading extends EndWorkState {}

final class EndWorkSuccess extends EndWorkState {}

final class EndWorkFailure extends EndWorkState {
  final String message;

  const EndWorkFailure({required this.message});

  @override
  List<Object> get props => [message];
}
