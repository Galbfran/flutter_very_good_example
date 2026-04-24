import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:{{package_name}}/features/{{name.snakeCase()}}/cubit/{{name.snakeCase()}}_cubit.dart';
import 'package:{{package_name}}/features/{{name.snakeCase()}}/cubit/{{name.snakeCase()}}_state.dart';

/// Reúne los [BlocListener] de la vista del contador.
class {{name.pascalCase()}}ViewListeners extends StatelessWidget {
  const {{name.pascalCase()}}ViewListeners({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocListener<{{name.pascalCase()}}Cubit, {{name.pascalCase()}}CubitState>(
      listenWhen: (previous, current) =>
          current.status == {{name.pascalCase()}}CubitStatus.failure,
      listener: _onFailure,
      child: child,
    );
  }

  static void _onFailure(
    BuildContext context,
    {{name.pascalCase()}}CubitState state,
  ) {
    final msg = state.errorMessage;
    if (msg != null && msg.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(msg)),
      );
    }
  }
}
