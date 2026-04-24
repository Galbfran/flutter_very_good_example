import 'package:{{package_name}}/features/{{name.snakeCase()}}/domain/{{name.snakeCase()}}_repository.dart';
import 'package:{{package_name}}/features/{{name.snakeCase()}}/domain/{{name.snakeCase()}}_snapshot.dart';

/// Simula latencia de red; misma interfaz que un cliente HTTP futuro.
class Simulated{{name.pascalCase()}}Repository implements {{name.pascalCase()}}Repository {
  Simulated{{name.pascalCase()}}Repository({
    this.networkDelay = const Duration(milliseconds: 350),
  });

  final Duration networkDelay;

  @override
  Future<{{name.pascalCase()}}Snapshot> increment({{name.pascalCase()}}Snapshot from) async {
    await Future<void>.delayed(networkDelay);
    final next = from.current + 1;
    return {{name.pascalCase()}}Snapshot(current: next, previous: from.current);
  }

  @override
  Future<{{name.pascalCase()}}Snapshot> decrement({{name.pascalCase()}}Snapshot from) async {
    await Future<void>.delayed(networkDelay);
    final next = from.current - 1;
    return {{name.pascalCase()}}Snapshot(current: next, previous: from.current);
  }
}
