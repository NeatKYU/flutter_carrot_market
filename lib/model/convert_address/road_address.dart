import 'package:collection/collection.dart';
import 'package:json_annotation/json_annotation.dart';

part 'road_address.g.dart';

@JsonSerializable()
class RoadAddress {
  @JsonKey(name: 'address_name')
  String? addressName;
  @JsonKey(name: 'region_1depth_name')
  String? region1depthName;
  @JsonKey(name: 'region_2depth_name')
  String? region2depthName;
  @JsonKey(name: 'region_3depth_name')
  String? region3depthName;
  @JsonKey(name: 'road_name')
  String? roadName;
  @JsonKey(name: 'underground_yn')
  String? undergroundYn;
  @JsonKey(name: 'main_building_no')
  String? mainBuildingNo;
  @JsonKey(name: 'sub_building_no')
  String? subBuildingNo;
  @JsonKey(name: 'building_name')
  String? buildingName;
  @JsonKey(name: 'zone_no')
  String? zoneNo;

  RoadAddress({
    this.addressName,
    this.region1depthName,
    this.region2depthName,
    this.region3depthName,
    this.roadName,
    this.undergroundYn,
    this.mainBuildingNo,
    this.subBuildingNo,
    this.buildingName,
    this.zoneNo,
  });

  factory RoadAddress.fromJson(Map<String, dynamic> json) {
    return _$RoadAddressFromJson(json);
  }

  Map<String, dynamic> toJson() => _$RoadAddressToJson(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! RoadAddress) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode =>
      addressName.hashCode ^
      region1depthName.hashCode ^
      region2depthName.hashCode ^
      region3depthName.hashCode ^
      roadName.hashCode ^
      undergroundYn.hashCode ^
      mainBuildingNo.hashCode ^
      subBuildingNo.hashCode ^
      buildingName.hashCode ^
      zoneNo.hashCode;
}
