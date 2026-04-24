import 'package:flutter/material.dart';
import 'package:flutter_very_good_example/core/router/app_routes.dart';
import 'package:flutter_very_good_example/l10n/l10n.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.homeAppBarTitle),
      ),
      body: Center(
        child: FilledButton.icon(
          onPressed: () => context.push(AppRoutes.counter.path),
          icon: const Icon(Icons.calculate_outlined),
          label: Text(l10n.homeOpenCounterButton),
        ),
      ),
    );
  }
}
