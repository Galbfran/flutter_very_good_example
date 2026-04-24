import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_very_good_example/features/counter/cubit/counter_cubit.dart';
import 'package:flutter_very_good_example/features/counter/domain/counter_repository.dart';
import 'package:flutter_very_good_example/features/counter/presentation/widgets/counter_view.dart';

class CounterPage extends StatelessWidget {
  const CounterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CounterCubit(context.read<CounterRepository>()),
      child: const CounterView(),
    );
  }
}
