import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_very_good_example/features/example/cubit/example_cubit.dart';
import 'package:flutter_very_good_example/features/example/cubit/example_state.dart';
import 'package:flutter_very_good_example/localization/localization.dart';

class ExampleBody extends StatelessWidget {
  const ExampleBody({super.key});

  @override
  Widget build(BuildContext context) {
    final localization = context.localization;
    return BlocBuilder<ExampleCubit, ExampleCubitState>(
      builder: (context, state) {
        final loading = state.status == ExampleCubitStatus.loading;
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
                '${localization.examplePreviousLabel}: '
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
