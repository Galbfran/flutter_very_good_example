import 'package:flutter/material.dart';
import 'package:flutter_very_good_example/core/presentation/presentation.dart';
import 'package:flutter_very_good_example/core/router/app_routes.dart';
import 'package:go_router/go_router.dart';

/// Pantalla inicial breve; navega a [AppRoutes.home].
class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future<void>.delayed(const Duration(milliseconds: 600), () {
        if (mounted) {
          context.go(AppRoutes.home.path);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: AppLoadingIndicator(),
      ),
    );
  }
}
