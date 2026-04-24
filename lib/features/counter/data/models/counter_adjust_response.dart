import 'package:json_annotation/json_annotation.dart';

part 'counter_adjust_response.g.dart';

/// Cuerpo JSON esperado del endpoint de ajuste del contador (ejemplo).
@JsonSerializable(createToJson: false)
class CounterAdjustResponse {
  const CounterAdjustResponse({
    required this.current,
    required this.previous,
  });

  factory CounterAdjustResponse.fromJson(Map<String, dynamic> json) =>
      _$CounterAdjustResponseFromJson(json);

  final int current;
  final int previous;
}
