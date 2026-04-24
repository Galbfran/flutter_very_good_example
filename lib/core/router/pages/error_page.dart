import 'package:flutter/material.dart';
import 'package:flutter_very_good_example/core/router/app_routes.dart';
import 'package:flutter_very_good_example/localization/localization.dart';
import 'package:go_router/go_router.dart';

/// Error genérico (red, lógica, etc.). Query opcional: `?message=`.
class ErrorPage extends StatelessWidget {
  const ErrorPage({this.message, super.key});

  final String? message;

  @override
  Widget build(BuildContext context) {
    final localization = context.localization;
    final trimmed = message?.trim();
    final text = (trimmed != null && trimmed.isNotEmpty)
        ? trimmed
        : localization.errorPageDefaultMessage;

    return Scaffold(
      appBar: AppBar(title: Text(localization.errorPageTitle)),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline,
                size: 72,
                color: Theme.of(context).colorScheme.error,
              ),
              const SizedBox(height: 24),
              Text(
                localization.errorPageTitle,
                style: Theme.of(context).textTheme.headlineSmall,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Text(
                text,
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                alignment: WrapAlignment.center,
                children: [
                  if (context.canPop())
                    OutlinedButton.icon(
                      onPressed: () => context.pop(),
                      icon: const Icon(Icons.arrow_back),
                      label: Text(localization.coreTryAgainButton),
                    ),
                  FilledButton.icon(
                    onPressed: () => context.go(AppRoutes.home.path),
                    icon: const Icon(Icons.home_outlined),
                    label: Text(localization.coreGoHomeButton),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
