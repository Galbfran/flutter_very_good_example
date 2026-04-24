import 'package:{{package_name}}/features/{{name.snakeCase()}}/domain/{{name.snakeCase()}}_snapshot.dart';

/// Contrato de acceso al contador (API real o implementación simulada).
abstract class {{name.pascalCase()}}Repository {
  Future<{{name.pascalCase()}}Snapshot> increment({{name.pascalCase()}}Snapshot from);

  Future<{{name.pascalCase()}}Snapshot> decrement({{name.pascalCase()}}Snapshot from);
}
