// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'results.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Results _$ResultsFromJson(Map<String, dynamic> json) => Results(
      common: json['common'] == null
          ? null
          : Common.fromJson(json['common'] as Map<String, dynamic>),
      juso: (json['juso'] as List<dynamic>?)
          ?.map((e) => Juso.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ResultsToJson(Results instance) => <String, dynamic>{
      'common': instance.common,
      'juso': instance.juso,
    };
