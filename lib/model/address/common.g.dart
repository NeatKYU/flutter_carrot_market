// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'common.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Common _$CommonFromJson(Map<String, dynamic> json) => Common(
      errorMessage: json['errorMessage'] as String?,
      countPerPage: json['countPerPage'] as String?,
      totalCount: json['totalCount'] as String?,
      errorCode: json['errorCode'] as String?,
      currentPage: json['currentPage'] as String?,
    );

Map<String, dynamic> _$CommonToJson(Common instance) => <String, dynamic>{
      'errorMessage': instance.errorMessage,
      'countPerPage': instance.countPerPage,
      'totalCount': instance.totalCount,
      'errorCode': instance.errorCode,
      'currentPage': instance.currentPage,
    };
