import 'package:bloc/bloc.dart';
import 'package:{{package_name}}/features/{{name.snakeCase()}}/cubit/{{name.snakeCase()}}_state.dart';
import 'package:{{package_name}}/features/{{name.snakeCase()}}/domain/{{name.snakeCase()}}_repository.dart';

class {{name.pascalCase()}}Cubit extends Cubit<{{name.pascalCase()}}CubitState> {
  {{name.pascalCase()}}Cubit(this._repository) : super(const {{name.pascalCase()}}CubitState());

  final {{name.pascalCase()}}Repository _repository;

  Future<void> increment() async {
    emit(
      state.copyWith(
        status: {{name.pascalCase()}}CubitStatus.loading,
        clearError: true,
      ),
    );
    try {
      final next = await _repository.increment(state.snapshot);
      emit(
        state.copyWith(
          status: {{name.pascalCase()}}CubitStatus.success,
          snapshot: next,
        ),
      );
    } on Object catch (error) {
      emit(
        state.copyWith(
          status: {{name.pascalCase()}}CubitStatus.failure,
          errorMessage: error.toString(),
        ),
      );
    }
  }

  Future<void> decrement() async {
    emit(
      state.copyWith(
        status: {{name.pascalCase()}}CubitStatus.loading,
        clearError: true,
      ),
    );
    try {
      final next = await _repository.decrement(state.snapshot);
      emit(
        state.copyWith(
          status: {{name.pascalCase()}}CubitStatus.success,
          snapshot: next,
        ),
      );
    } on Object catch (error) {
      emit(
        state.copyWith(
          status: {{name.pascalCase()}}CubitStatus.failure,
          errorMessage: error.toString(),
        ),
      );
    }
  }
}
