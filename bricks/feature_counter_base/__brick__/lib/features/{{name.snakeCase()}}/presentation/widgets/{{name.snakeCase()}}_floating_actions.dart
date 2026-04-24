import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:{{package_name}}/features/{{name.snakeCase()}}/cubit/{{name.snakeCase()}}_cubit.dart';
import 'package:{{package_name}}/features/{{name.snakeCase()}}/cubit/{{name.snakeCase()}}_state.dart';

class {{name.pascalCase()}}FloatingActions extends StatelessWidget {
  const {{name.pascalCase()}}FloatingActions({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<{{name.pascalCase()}}Cubit, {{name.pascalCase()}}CubitState, bool>(
      selector: (state) => state.status == {{name.pascalCase()}}CubitStatus.loading,
      builder: (context, loading) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            FloatingActionButton(
              heroTag: '{{name.snakeCase()}}_fab_increment',
              onPressed: loading
                  ? null
                  : () => context.read<{{name.pascalCase()}}Cubit>().increment(),
              child: const Icon(Icons.add),
            ),
            const SizedBox(height: 8),
            FloatingActionButton(
              heroTag: '{{name.snakeCase()}}_fab_decrement',
              onPressed: loading
                  ? null
                  : () => context.read<{{name.pascalCase()}}Cubit>().decrement(),
              child: const Icon(Icons.remove),
            ),
          ],
        );
      },
    );
  }
}
