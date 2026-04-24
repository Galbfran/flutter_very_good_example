import 'package:flutter/material.dart';

/// Paleta y tokens de color. El [ColorScheme] principal se deriva con
/// [ColorScheme.fromSeed] a partir de [brand].
abstract final class AppColors {
  /// Color de marca; define el matiz del tema Material 3.
  static const Color brand = Color(0xFF1565C0);

  /// Acento secundario explícito (opcional; el seed ya genera secondary).
  static const Color accent = Color(0xFF00838F);

  /// Estados semánticos (podés enlazarlos en componentes concretos).
  static const Color success = Color(0xFF2E7D32);
  static const Color warning = Color(0xFFF57C00);
  static const Color danger = Color(0xFFC62828);
}
