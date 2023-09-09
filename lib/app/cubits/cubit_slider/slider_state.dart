part of 'slider_cubit.dart';

sealed class SliderState extends Equatable {
  const SliderState(this.ref);
  final Reference ref;
  @override
  List<Object> get props => [ref];
}

final class SliderInitial extends SliderState {
  SliderInitial(super.ref);
}

final class SliderLoaded extends SliderState {
  final String url;

  const SliderLoaded(super.ref, {required this.url});
}

final class SliderError extends SliderState {
  SliderError(super.ref, {required this.message});
  final String message;
}
