// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json, userKey, refernce) => UserModel(
      // 아래 두 값은 파라미터로 전달
      userKey: userKey,
      phoneNumber: json['phoneNumber'] as String,
      address: json['address'] as String,
      // lat: json['lat'] as int,
      // lon: json['lon'] as int,
      // geoFirePoint: (json['geoFirePoint']['geopoint']).latitude as GeoFirePoint,
      geoFirePoint: GeoFirePoint((json['geoFirePoint']['geopoint']).latitude,
          (json['geoFirePoint']['geopoint']).longitude),
      createdDate: json['createdDate'] == null
          ? DateTime.now().toUtc()
          : (json['createdDate'] as Timestamp).toDate(),
      reference: refernce,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      // 'userKey': instance.userKey,
      'phoneNumber': instance.phoneNumber,
      'address': instance.address,
      // 'lat': instance.lat,
      // 'lon': instance.lon,
      'geoFirePoint': instance.geoFirePoint.data,
      'createdDate': instance.createdDate,
      // 'reference': instance.reference,
    };
