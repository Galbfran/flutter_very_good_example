import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_very_good_example/features/example/cubit/example_cubit.dart';
import 'package:flutter_very_good_example/features/example/cubit/example_state.dart';

/// Reúne los [BlocListener] de la vista del contador.
///
/// Con varios listeners podés anidarlos aquí o envolver con
/// [MultiBlocListener].
class ExampleViewListeners extends StatelessWidget {
  const ExampleViewListeners({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocListener<ExampleCubit, ExampleCubitState>(
      listenWhen: (previous, current) =>
          current.status == ExampleCubitStatus.failure,
      listener: _onExampleFailure,
      child: child,
    );
  }

  static void _onExampleFailure(
    BuildContext context,
    ExampleCubitState state,
  ) {
    final msg = state.errorMessage;
    if (msg != null && msg.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(msg)),
      );
    }
  }
}
