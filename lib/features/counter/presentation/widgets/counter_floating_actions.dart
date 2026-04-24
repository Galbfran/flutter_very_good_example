import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_very_good_example/features/counter/cubit/counter_cubit.dart';
import 'package:flutter_very_good_example/features/counter/cubit/counter_state.dart';

class CounterFloatingActions extends StatelessWidget {
  const CounterFloatingActions({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<CounterCubit, CounterCubitState, bool>(
      selector: (state) => state.status == CounterCubitStatus.loading,
      builder: (context, loading) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            FloatingActionButton(
              heroTag: 'counter_fab_increment',
              onPressed: loading
                  ? null
                  : () => context.read<CounterCubit>().increment(),
              child: const Icon(Icons.add),
            ),
            const SizedBox(height: 8),
            FloatingActionButton(
              heroTag: 'counter_fab_decrement',
              onPressed: loading
                  ? null
                  : () => context.read<CounterCubit>().decrement(),
              child: const Icon(Icons.remove),
            ),
          ],
        );
      },
    );
  }
}
