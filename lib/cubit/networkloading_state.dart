part of 'networkloading_cubit.dart';

@immutable
sealed class NetworkloadingState {}

final class NetworkloadingInitial extends NetworkloadingState {}

class NetworkSuccess extends NetworkloadingState {
  final List<String> data;

  NetworkSuccess(this.data);
}

class NetworkFailure extends NetworkloadingState {
  final String error;

  NetworkFailure(this.error);
}
