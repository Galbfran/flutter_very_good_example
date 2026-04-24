import 'package:bloc/bloc.dart';
import 'package:flutter_very_good_example/features/example/cubit/example_state.dart';
import 'package:flutter_very_good_example/features/example/domain/example_repository.dart';

class ExampleCubit extends Cubit<ExampleCubitState> {
  ExampleCubit(this._repository) : super(const ExampleCubitState());

  final ExampleRepository _repository;

  Future<void> increment() async {
    emit(
      state.copyWith(
        status: ExampleCubitStatus.loading,
        clearError: true,
      ),
    );
    try {
      final next = await _repository.increment(state.snapshot);
      emit(
        state.copyWith(
          status: ExampleCubitStatus.success,
          snapshot: next,
        ),
      );
    } on Object catch (error) {
      emit(
        state.copyWith(
          status: ExampleCubitStatus.failure,
          errorMessage: error.toString(),
        ),
      );
    }
  }

  Future<void> decrement() async {
    emit(
      state.copyWith(
        status: ExampleCubitStatus.loading,
        clearError: true,
      ),
    );
    try {
      final next = await _repository.decrement(state.snapshot);
      emit(
        state.copyWith(
          status: ExampleCubitStatus.success,
          snapshot: next,
        ),
      );
    } on Object catch (error) {
      emit(
        state.copyWith(
          status: ExampleCubitStatus.failure,
          errorMessage: error.toString(),
        ),
      );
    }
  }
}
