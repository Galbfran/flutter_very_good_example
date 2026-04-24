import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_very_good_example/features/counter/counter.dart';

class MockCounterCubit extends MockCubit<CounterCubitState>
    implements CounterCubit {}
