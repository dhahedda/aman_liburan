import 'package:json_annotation/json_annotation.dart';

part 'place_model.g.dart';

@JsonSerializable()
class Place {
    Place({
        this.id,
    });

    Id id;

  factory Place.fromJson(Map<String, dynamic> json) => _$PlaceFromJson(json);

  Map<String, dynamic> toJson() => _$PlaceToJson(this);
}


@JsonSerializable()
class Id {
    Id({
        this.placeCategory,
        this.placeDescription,
        this.placeHourClose,
        this.placeHourOpen,
        this.placeId,
        this.placeIsOpen,
        this.placeLatitude,
        this.placeLocation,
        this.placeLongitude,
        this.placeMaxVisitor,
        this.placeName,
        this.placePicture,
        this.placePrice,
    });

    int placeCategory;
    String placeDescription;
    String placeHourClose;
    String placeHourOpen;
    String placeId;
    bool placeIsOpen;
    double placeLatitude;
    String placeLocation;
    double placeLongitude;
    int placeMaxVisitor;
    String placeName;
    String placePicture;
    String placePrice;

  factory Id.fromJson(Map<String, dynamic> json) => _$IdFromJson(json);

  Map<String, dynamic> toJson() => _$IdToJson(this);
}
