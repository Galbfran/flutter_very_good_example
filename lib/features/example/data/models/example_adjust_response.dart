import 'package:json_annotation/json_annotation.dart';

part 'example_adjust_response.g.dart';

/// Cuerpo JSON esperado del endpoint de ajuste del contador (ejemplo).
@JsonSerializable(createToJson: false)
class ExampleAdjustResponse {
  const ExampleAdjustResponse({
    required this.current,
    required this.previous,
  });

  factory ExampleAdjustResponse.fromJson(Map<String, dynamic> json) =>
      _$ExampleAdjustResponseFromJson(json);

  final int current;
  final int previous;
}
