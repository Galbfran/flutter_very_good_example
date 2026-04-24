import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_very_good_example/features/example/cubit/example_cubit.dart';
import 'package:flutter_very_good_example/features/example/cubit/example_state.dart';

class ExampleFloatingActions extends StatelessWidget {
  const ExampleFloatingActions({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<ExampleCubit, ExampleCubitState, bool>(
      selector: (state) => state.status == ExampleCubitStatus.loading,
      builder: (context, loading) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            FloatingActionButton(
              heroTag: 'example_fab_increment',
              onPressed: loading
                  ? null
                  : () => context.read<ExampleCubit>().increment(),
              child: const Icon(Icons.add),
            ),
            const SizedBox(height: 8),
            FloatingActionButton(
              heroTag: 'example_fab_decrement',
              onPressed: loading
                  ? null
                  : () => context.read<ExampleCubit>().decrement(),
              child: const Icon(Icons.remove),
            ),
          ],
        );
      },
    );
  }
}
