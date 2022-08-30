// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'convert_address.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConvertAddress _$ConvertAddressFromJson(Map<String, dynamic> json) =>
    ConvertAddress(
      meta: json['meta'] == null
          ? null
          : Meta.fromJson(json['meta'] as Map<String, dynamic>),
      documents: (json['documents'] as List<dynamic>?)
          ?.map((e) => Document.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ConvertAddressToJson(ConvertAddress instance) =>
    <String, dynamic>{
      'meta': instance.meta,
      'documents': instance.documents,
    };
