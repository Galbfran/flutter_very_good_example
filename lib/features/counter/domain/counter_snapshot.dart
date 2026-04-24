import 'package:equatable/equatable.dart';

/// Valor del contador tal como lo consume la UI (tras capa de datos).
///
/// [previous] refleja el valor antes de la última operación exitosa; en el
/// estado inicial suele coincidir con [current] (p. ej. 0 y 0).
class CounterSnapshot extends Equatable {
  const CounterSnapshot({
    required this.current,
    required this.previous,
  });

  final int current;
  final int previous;

  @override
  List<Object?> get props => [current, previous];
}
