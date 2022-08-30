// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'road_address.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RoadAddress _$RoadAddressFromJson(Map<String, dynamic> json) => RoadAddress(
      addressName: json['address_name'] as String?,
      buildingName: json['building_name'] as String?,
      mainBuildingNo: json['main_building_no'] as String?,
      region1depthName: json['region_1depth_name'] as String?,
      region2depthName: json['region_2depth_name'] as String?,
      region3depthName: json['region_3depth_name'] as String?,
      roadName: json['road_name'] as String?,
      subBuildingNo: json['sub_building_no'] as String?,
      undergroundYn: json['underground_yn'] as String?,
      x: json['x'] as String?,
      y: json['y'] as String?,
      zoneNo: json['zone_no'] as String?,
    );

Map<String, dynamic> _$RoadAddressToJson(RoadAddress instance) =>
    <String, dynamic>{
      'address_name': instance.addressName,
      'building_name': instance.buildingName,
      'main_building_no': instance.mainBuildingNo,
      'region_1depth_name': instance.region1depthName,
      'region_2depth_name': instance.region2depthName,
      'region_3depth_name': instance.region3depthName,
      'road_name': instance.roadName,
      'sub_building_no': instance.subBuildingNo,
      'underground_yn': instance.undergroundYn,
      'x': instance.x,
      'y': instance.y,
      'zone_no': instance.zoneNo,
    };
