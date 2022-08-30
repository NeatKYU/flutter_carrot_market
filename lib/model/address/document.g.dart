// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'document.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Document _$DocumentFromJson(Map<String, dynamic> json) => Document(
      address: json['address'],
      addressName: json['address_name'] as String?,
      addressType: json['address_type'] as String?,
      roadAddress: json['road_address'] == null
          ? null
          : RoadAddress.fromJson(json['road_address'] as Map<String, dynamic>),
      x: json['x'] as String?,
      y: json['y'] as String?,
    );

Map<String, dynamic> _$DocumentToJson(Document instance) => <String, dynamic>{
      'address': instance.address,
      'address_name': instance.addressName,
      'address_type': instance.addressType,
      'road_address': instance.roadAddress,
      'x': instance.x,
      'y': instance.y,
    };
