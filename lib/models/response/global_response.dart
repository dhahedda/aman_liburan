
import 'package:aman_liburan/models/response/data_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'global_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class GlobalResponse{
  String status;
  String message;
  String error;
  DataResponse data;

  GlobalResponse({this.status, this.message, this.data});

  factory GlobalResponse.fromJson(Map<String, dynamic> json) => _$GlobalResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GlobalResponseToJson(this);

  @override
  String toString() {
    return 'GlobalResponse{status: $status, message: $message, error: $error, data: $data}';
  }

  GlobalResponse.withError(String errorValue) : error = errorValue;
}