import 'package:bloc/bloc.dart';
import 'package:flutter_very_good_example/features/counter/cubit/counter_state.dart';
import 'package:flutter_very_good_example/features/counter/domain/counter_repository.dart';

class CounterCubit extends Cubit<CounterCubitState> {
  CounterCubit(this._repository) : super(const CounterCubitState());

  final CounterRepository _repository;

  Future<void> increment() async {
    emit(
      state.copyWith(
        status: CounterCubitStatus.loading,
        clearError: true,
      ),
    );
    try {
      final next = await _repository.increment(state.snapshot);
      emit(
        state.copyWith(
          status: CounterCubitStatus.success,
          snapshot: next,
        ),
      );
    } on Object catch (error) {
      emit(
        state.copyWith(
          status: CounterCubitStatus.failure,
          errorMessage: error.toString(),
        ),
      );
    }
  }

  Future<void> decrement() async {
    emit(
      state.copyWith(
        status: CounterCubitStatus.loading,
        clearError: true,
      ),
    );
    try {
      final next = await _repository.decrement(state.snapshot);
      emit(
        state.copyWith(
          status: CounterCubitStatus.success,
          snapshot: next,
        ),
      );
    } on Object catch (error) {
      emit(
        state.copyWith(
          status: CounterCubitStatus.failure,
          errorMessage: error.toString(),
        ),
      );
    }
  }
}
