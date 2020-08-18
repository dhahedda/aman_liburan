import 'package:json_annotation/json_annotation.dart';

part 'location_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class LocationResponse {
    double latitude;
    double longitude;

    LocationResponse({
        this.latitude,
        this.longitude,
    });

    factory LocationResponse.fromJson(Map<String, dynamic> json) => _$LocationResponseFromJson(json);

    Map<String, dynamic> toJson() => _$LocationResponseToJson(this);  
}