import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:{{package_name}}/features/{{name.snakeCase()}}/cubit/{{name.snakeCase()}}_cubit.dart';
import 'package:{{package_name}}/features/{{name.snakeCase()}}/domain/{{name.snakeCase()}}_repository.dart';
import 'package:{{package_name}}/features/{{name.snakeCase()}}/presentation/widgets/{{name.snakeCase()}}_view.dart';

class {{name.pascalCase()}}Page extends StatelessWidget {
  const {{name.pascalCase()}}Page({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => {{name.pascalCase()}}Cubit(context.read<{{name.pascalCase()}}Repository>()),
      child: const {{name.pascalCase()}}View(),
    );
  }
}
