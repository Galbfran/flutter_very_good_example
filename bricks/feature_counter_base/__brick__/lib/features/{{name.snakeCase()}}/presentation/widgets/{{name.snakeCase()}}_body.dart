import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:{{package_name}}/features/{{name.snakeCase()}}/cubit/{{name.snakeCase()}}_cubit.dart';
import 'package:{{package_name}}/features/{{name.snakeCase()}}/cubit/{{name.snakeCase()}}_state.dart';

class {{name.pascalCase()}}Body extends StatelessWidget {
  const {{name.pascalCase()}}Body({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<{{name.pascalCase()}}Cubit, {{name.pascalCase()}}CubitState>(
      builder: (context, state) {
        final loading = state.status == {{name.pascalCase()}}CubitStatus.loading;
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
                'Previous: ${state.snapshot.previous}',
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
