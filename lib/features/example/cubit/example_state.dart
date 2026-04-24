import 'package:equatable/equatable.dart';
import 'package:flutter_very_good_example/features/example/domain/example_snapshot.dart';

enum ExampleCubitStatus { initial, loading, success, failure }

class ExampleCubitState extends Equatable {
  const ExampleCubitState({
    this.status = ExampleCubitStatus.initial,
    this.snapshot = const ExampleSnapshot(current: 0, previous: 0),
    this.errorMessage,
  });

  final ExampleCubitStatus status;
  final ExampleSnapshot snapshot;
  final String? errorMessage;

  ExampleCubitState copyWith({
    ExampleCubitStatus? status,
    ExampleSnapshot? snapshot,
    String? errorMessage,
    bool clearError = false,
  }) {
    return ExampleCubitState(
      status: status ?? this.status,
      snapshot: snapshot ?? this.snapshot,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }

  @override
  List<Object?> get props => [status, snapshot, errorMessage];
}
