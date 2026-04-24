import 'package:flutter/material.dart';
import 'package:flutter_very_good_example/features/example/presentation/widgets/example_body.dart';
import 'package:flutter_very_good_example/features/example/presentation/widgets/example_floating_actions.dart';
import 'package:flutter_very_good_example/features/example/presentation/widgets/example_scaffold.dart';
import 'package:flutter_very_good_example/features/example/presentation/widgets/example_view_listeners.dart';
import 'package:flutter_very_good_example/localization/localization.dart';

class ExampleView extends StatelessWidget {
  const ExampleView({super.key});

  @override
  Widget build(BuildContext context) {
    final localization = context.localization;
    return ExampleViewListeners(
      child: ExampleScaffold(
        title: Text(localization.exampleAppBarTitle),
        body: const ExampleBody(),
        floatingActionButton: const ExampleFloatingActions(),
      ),
    );
  }
}
