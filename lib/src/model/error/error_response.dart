library errorresponse;

import 'package:json_annotation/json_annotation.dart';

part 'error_response.g.dart';

@JsonSerializable()
class ErrorResponse {
  String error;

  factory ErrorResponse.fromJson(Map<String, dynamic> json) =>
      _$ErrorResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ErrorResponseToJson(this);

  static const fromJsonFactory = _$ErrorResponseFromJson;

  ErrorResponse();

  @override
  String toString() {
    return 'ErrorResponse{error: $error}';
  }
}
