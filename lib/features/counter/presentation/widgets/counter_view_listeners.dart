import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_very_good_example/features/counter/cubit/counter_cubit.dart';
import 'package:flutter_very_good_example/features/counter/cubit/counter_state.dart';

/// Reúne los [BlocListener] de la vista del contador.
///
/// Con varios listeners podés anidarlos aquí o envolver con
/// [MultiBlocListener].
class CounterViewListeners extends StatelessWidget {
  const CounterViewListeners({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocListener<CounterCubit, CounterCubitState>(
      listenWhen: (previous, current) =>
          current.status == CounterCubitStatus.failure,
      listener: _onCounterFailure,
      child: child,
    );
  }

  static void _onCounterFailure(
    BuildContext context,
    CounterCubitState state,
  ) {
    final msg = state.errorMessage;
    if (msg != null && msg.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(msg)),
      );
    }
  }
}
