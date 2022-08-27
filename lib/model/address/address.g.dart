// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Address _$AddressFromJson(Map<String, dynamic> json) => Address(
      results: json['results'] == null
          ? null
          : Results.fromJson(json['results'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AddressToJson(Address instance) => <String, dynamic>{
      'results': instance.results,
    };
