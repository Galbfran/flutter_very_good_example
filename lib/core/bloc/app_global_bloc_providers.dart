import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Envuelve la app con [MultiBlocProvider] para Cubits/Blocs globales.
///
/// Registrá aquí estado que compartan varias rutas o features. Lo que sea
/// solo de una pantalla, dejalo en un [BlocProvider] más abajo en el árbol.
///
/// Mientras la lista esté vacía, se devuelve [child] sin envolver (evita el
/// assert de [MultiBlocProvider] con `providers` vacíos).
class AppGlobalBlocProviders extends StatelessWidget {
  const AppGlobalBlocProviders({required this.child, super.key});

  final Widget child;

  static List<BlocProvider<Object?>> _globalProviders() {
    return [
      // Ej.: BlocProvider<AuthBloc>(create: (_) => AuthBloc()..add(...)),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final providers = _globalProviders();
    if (providers.isEmpty) {
      return child;
    }
    return MultiBlocProvider(
      providers: providers,
      child: child,
    );
  }
}
