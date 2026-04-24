import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_very_good_example/features/counter/cubit/counter_cubit.dart';
import 'package:flutter_very_good_example/features/counter/cubit/counter_state.dart';
import 'package:flutter_very_good_example/localization/localization.dart';

class CounterBody extends StatelessWidget {
  const CounterBody({super.key});

  @override
  Widget build(BuildContext context) {
    final localization = context.localization;
    return BlocBuilder<CounterCubit, CounterCubitState>(
      builder: (context, state) {
        final loading = state.status == CounterCubitStatus.loading;
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (loading) const LinearProgressIndicator(),
              const SizedBox(height: 16),
              Text(
                '${state.snapshot.current}',
                style: Theme.of(context).textTheme.displayLarge,
              ),
              const SizedBox(height: 8),
              Text(
                '${localization.counterPreviousLabel}: '
                '${state.snapshot.previous}',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
              ),
            ],
          ),
        );
      },
    );
  }
}
