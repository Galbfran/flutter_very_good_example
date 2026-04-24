import 'package:flutter/material.dart';

/// Armazón de pantalla fuera del contenido reactivo al cubit: el shell no se
/// reconstruye en cada emisión (solo si cambia el padre, p. ej. tema o locale).
class ExampleScaffold extends StatelessWidget {
  const ExampleScaffold({
    required this.title,
    required this.body,
    required this.floatingActionButton,
    super.key,
  });

  final Widget title;
  final Widget body;
  final Widget floatingActionButton;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: title),
      body: body,
      floatingActionButton: floatingActionButton,
    );
  }
}
