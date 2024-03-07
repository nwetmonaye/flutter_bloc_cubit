import 'package:bloc/bloc.dart';
import 'package:flutter/physics.dart';
import 'package:meta/meta.dart';

part 'networkloading_state.dart';

class NetworkloadingCubit extends Cubit<NetworkloadingState> {
  NetworkloadingCubit() : super(NetworkloadingInitial());

  void loading() {
    emit(NetworkloadingInitial());
  }

  void success() {
    List<String> list = [];
    for (int i = 0; i < 10; i++) {
      list.add('Item $i');
    }
    emit(NetworkSuccess(list));
  }

  void fail() {
    emit(NetworkFailure('This is error'));
  }
}
