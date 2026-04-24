import 'package:equatable/equatable.dart';
import 'package:{{package_name}}/features/{{name.snakeCase()}}/domain/{{name.snakeCase()}}_snapshot.dart';

enum {{name.pascalCase()}}CubitStatus { initial, loading, success, failure }

class {{name.pascalCase()}}CubitState extends Equatable {
  const {{name.pascalCase()}}CubitState({
    this.status = {{name.pascalCase()}}CubitStatus.initial,
    this.snapshot = const {{name.pascalCase()}}Snapshot(current: 0, previous: 0),
    this.errorMessage,
  });

  final {{name.pascalCase()}}CubitStatus status;
  final {{name.pascalCase()}}Snapshot snapshot;
  final String? errorMessage;

  {{name.pascalCase()}}CubitState copyWith({
    {{name.pascalCase()}}CubitStatus? status,
    {{name.pascalCase()}}Snapshot? snapshot,
    String? errorMessage,
    bool clearError = false,
  }) {
    return {{name.pascalCase()}}CubitState(
      status: status ?? this.status,
      snapshot: snapshot ?? this.snapshot,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }

  @override
  List<Object?> get props => [status, snapshot, errorMessage];
}
