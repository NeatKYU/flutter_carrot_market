// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItemModel _$ItemModelFromJson(Map<String, dynamic> json, itemKey, reference) =>
    ItemModel(
      itemKey: itemKey,
      userKey: json['userKey'] ?? "",
      imageDownloadUrls: (json['imageDownloadUrls'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      title: json['title'] ?? "",
      category: json['category'] ?? "none",
      price: json['price'] ?? 0,
      nego: json['nego'] ?? false,
      detail: json['detail'] ?? "",
      address: json['address'] ?? "",
      geoFirePoint: GeoFirePoint((json['geoFirePoint']['geopoint']).latitude,
          (json['geoFirePoint']['geopoint']).longitude),
      createdDate: json['createdDate'] == null
          ? DateTime.now().toUtc()
          : (json['createdDate'] as Timestamp).toDate(),
      reference: reference,
    );

Map<String, dynamic> _$ItemModelToJson(ItemModel instance) => <String, dynamic>{
      // 'itemKey': instance.itemKey,
      'userKey': instance.userKey,
      'imageDownloadUrls': instance.imageDownloadUrls,
      'title': instance.title,
      'category': instance.category,
      'price': instance.price,
      'nego': instance.nego,
      'detail': instance.detail,
      'address': instance.address,
      'geoFirePoint': instance.geoFirePoint.data,
      'createdDate': instance.createdDate,
      // 'reference': instance.reference,
    };
