import 'package:flutter/material.dart';
import 'package:flutter_very_good_example/features/counter/presentation/widgets/counter_body.dart';
import 'package:flutter_very_good_example/features/counter/presentation/widgets/counter_floating_actions.dart';
import 'package:flutter_very_good_example/features/counter/presentation/widgets/counter_scaffold.dart';
import 'package:flutter_very_good_example/features/counter/presentation/widgets/counter_view_listeners.dart';
import 'package:flutter_very_good_example/localization/localization.dart';

class CounterView extends StatelessWidget {
  const CounterView({super.key});

  @override
  Widget build(BuildContext context) {
    final localization = context.localization;
    return CounterViewListeners(
      child: CounterScaffold(
        title: Text(localization.counterAppBarTitle),
        body: const CounterBody(),
        floatingActionButton: const CounterFloatingActions(),
      ),
    );
  }
}
