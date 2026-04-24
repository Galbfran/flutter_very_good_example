import 'package:json_annotation/json_annotation.dart';

part '{{name.snakeCase()}}_adjust_response.g.dart';

/// Cuerpo JSON esperado del endpoint de ajuste del contador (ejemplo).
@JsonSerializable(createToJson: false)
class {{name.pascalCase()}}AdjustResponse {
  const {{name.pascalCase()}}AdjustResponse({
    required this.current,
    required this.previous,
  });

  factory {{name.pascalCase()}}AdjustResponse.fromJson(Map<String, dynamic> json) =>
      _${{name.pascalCase()}}AdjustResponseFromJson(json);

  final int current;
  final int previous;
}
