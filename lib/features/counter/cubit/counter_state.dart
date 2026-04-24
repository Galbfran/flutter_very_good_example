import 'package:equatable/equatable.dart';
import 'package:flutter_very_good_example/features/counter/domain/counter_snapshot.dart';

enum CounterCubitStatus { initial, loading, success, failure }

class CounterCubitState extends Equatable {
  const CounterCubitState({
    this.status = CounterCubitStatus.initial,
    this.snapshot = const CounterSnapshot(current: 0, previous: 0),
    this.errorMessage,
  });

  final CounterCubitStatus status;
  final CounterSnapshot snapshot;
  final String? errorMessage;

  CounterCubitState copyWith({
    CounterCubitStatus? status,
    CounterSnapshot? snapshot,
    String? errorMessage,
    bool clearError = false,
  }) {
    return CounterCubitState(
      status: status ?? this.status,
      snapshot: snapshot ?? this.snapshot,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }

  @override
  List<Object?> get props => [status, snapshot, errorMessage];
}
