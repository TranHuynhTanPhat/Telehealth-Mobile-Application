part of 'error_cubit.dart';

sealed class ErrorState extends Equatable {
  const ErrorState(this.ref);
  final Reference ref;

  @override
  List<Object> get props => [];
}

final class ErrorInitial extends ErrorState {
  const ErrorInitial(super.ref);
}

final class ErrorLoaded extends ErrorState {
  const ErrorLoaded(super.ref, {required this.url});
  final String url;
}

final class ErrorInvalid extends ErrorState {
  final String message;

  const ErrorInvalid(super.ref, {required this.message});
}
