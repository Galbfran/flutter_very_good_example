import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_very_good_example/features/example/cubit/example_cubit.dart';
import 'package:flutter_very_good_example/features/example/domain/example_repository.dart';
import 'package:flutter_very_good_example/features/example/presentation/widgets/example_view.dart';

class ExamplePage extends StatelessWidget {
  const ExamplePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ExampleCubit(context.read<ExampleRepository>()),
      child: const ExampleView(),
    );
  }
}
