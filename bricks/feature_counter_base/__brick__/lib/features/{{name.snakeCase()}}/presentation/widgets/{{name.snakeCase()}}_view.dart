import 'package:flutter/material.dart';
import 'package:{{package_name}}/features/{{name.snakeCase()}}/presentation/widgets/{{name.snakeCase()}}_body.dart';
import 'package:{{package_name}}/features/{{name.snakeCase()}}/presentation/widgets/{{name.snakeCase()}}_floating_actions.dart';
import 'package:{{package_name}}/features/{{name.snakeCase()}}/presentation/widgets/{{name.snakeCase()}}_scaffold.dart';
import 'package:{{package_name}}/features/{{name.snakeCase()}}/presentation/widgets/{{name.snakeCase()}}_view_listeners.dart';

/// Textos en código: migrá a l10n como en el feature `example`.
class {{name.pascalCase()}}View extends StatelessWidget {
  const {{name.pascalCase()}}View({super.key});

  @override
  Widget build(BuildContext context) {
    return {{name.pascalCase()}}ViewListeners(
      child: {{name.pascalCase()}}Scaffold(
        title: Text('{{name.pascalCase()}}'),
        body: const {{name.pascalCase()}}Body(),
        floatingActionButton: const {{name.pascalCase()}}FloatingActions(),
      ),
    );
  }
}
