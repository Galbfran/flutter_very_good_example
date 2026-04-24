// GENERATED CODE - DO NOT MODIFY BY HAND
// Consider adding this file to your .gitignore.

import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';


import 'core/network/dio_client_test.dart' as _a;
import 'core/network/dio_logger_interceptor_test.dart' as _b;
import 'core/router/app_router_test.dart' as _c;
import 'app/view/app_test.dart' as _d;
import 'features/example/cubit/example_state_test.dart' as _e;
import 'features/example/cubit/example_cubit_test.dart' as _f;
import 'features/example/data/interceptors/example_mock_interceptor_test.dart' as _g;
import 'features/example/data/api_example_repository_test.dart' as _h;
import 'features/example/data/simulated_example_repository_test.dart' as _i;
import 'features/example/domain/example_snapshot_test.dart' as _j;
import 'features/example/presentation/pages/example_page_test.dart' as _k;
import 'features/example/presentation/widgets/example_view_listeners_test.dart' as _l;
import 'features/example/presentation/widgets/example_view_test.dart' as _m;
import 'features/example/presentation/widgets/example_floating_actions_test.dart' as _n;
import 'features/example/presentation/widgets/example_body_test.dart' as _o;

void main() {
  goldenFileComparator = _TestOptimizationAwareGoldenFileComparator(goldenFileComparator as LocalFileComparator);
  group('core/network/dio_client_test.dart', () { _a.main(); });
  group('core/network/dio_logger_interceptor_test.dart', () { _b.main(); });
  group('core/router/app_router_test.dart', () { _c.main(); });
  group('app/view/app_test.dart', () { _d.main(); });
  group('features/example/cubit/example_state_test.dart', () { _e.main(); });
  group('features/example/cubit/example_cubit_test.dart', () { _f.main(); });
  group('features/example/data/interceptors/example_mock_interceptor_test.dart', () { _g.main(); });
  group('features/example/data/api_example_repository_test.dart', () { _h.main(); });
  group('features/example/data/simulated_example_repository_test.dart', () { _i.main(); });
  group('features/example/domain/example_snapshot_test.dart', () { _j.main(); });
  group('features/example/presentation/pages/example_page_test.dart', () { _k.main(); });
  group('features/example/presentation/widgets/example_view_listeners_test.dart', () { _l.main(); });
  group('features/example/presentation/widgets/example_view_test.dart', () { _m.main(); });
  group('features/example/presentation/widgets/example_floating_actions_test.dart', () { _n.main(); });
  group('features/example/presentation/widgets/example_body_test.dart', () { _o.main(); });
}


class _TestOptimizationAwareGoldenFileComparator extends GoldenFileComparator {
  final List<String> goldenFilePaths;
  final LocalFileComparator previousGoldenFileComparator;

  _TestOptimizationAwareGoldenFileComparator(this.previousGoldenFileComparator)
      : goldenFilePaths = _goldenFilePaths;

  static List<String> get _goldenFilePaths =>
      Directory.fromUri((goldenFileComparator as LocalFileComparator).basedir)
          .listSync(recursive: true, followLinks: true)
          .whereType<File>()
          .map((file) => file.path)
          .where((path) => path.endsWith('.png'))
          .toList();
  @override
  Future<bool> compare(Uint8List imageBytes, Uri golden)  => previousGoldenFileComparator.compare(imageBytes, golden);

  @override
  Uri getTestUri(Uri key, int? version) {
    final keyString = key.toFilePath();
    return Uri.parse(goldenFilePaths
        .singleWhere((goldenFilePath) => goldenFilePath.endsWith(keyString)));
  }

  @override
  Future<void> update(Uri golden, Uint8List imageBytes) => previousGoldenFileComparator.update(golden, imageBytes);

}
