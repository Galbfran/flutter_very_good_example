import 'package:flutter/material.dart';
import 'package:flutter_very_good_example/core/router/app_routes.dart';
import 'package:flutter_very_good_example/localization/localization.dart';
import 'package:go_router/go_router.dart';

/// Ruta inexistente o URL inválida. Usada por el `errorBuilder` del router.
class NotFoundPage extends StatelessWidget {
  const NotFoundPage({super.key});

  @override
  Widget build(BuildContext context) {
    final localization = context.localization;
    return Scaffold(
      appBar: AppBar(title: Text(localization.notFoundPageTitle)),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.search_off_outlined,
                size: 72,
                color: Theme.of(context).colorScheme.outline,
              ),
              const SizedBox(height: 24),
              Text(
                localization.notFoundPageTitle,
                style: Theme.of(context).textTheme.headlineSmall,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Text(
                localization.notFoundPageBody,
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              FilledButton.icon(
                onPressed: () => context.go(AppRoutes.home.path),
                icon: const Icon(Icons.home_outlined),
                label: Text(localization.coreGoHomeButton),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
