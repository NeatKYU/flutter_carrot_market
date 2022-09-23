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
      geoFirePoint: json['geoFirePoint'] == null
          ? GeoFirePoint(0, 0)
          : GeoFirePoint((json['geoFirePoint']['geopoint']).latitude,
              (json['geoFirePoint']['geopoint']).longitude),
      createdDate: json['createdDate'] == null
          ? DateTime.now().toUtc()
          : (json['createdDate'] as Timestamp).toDate(),
      reference: reference,
    );

ItemModel _$ItemModelFromMinJson(Map<String, dynamic> json, itemKey) =>
    ItemModel.min(
      imageDownloadUrls:
          (json['imageDownloadUrls'] as List<String>).sublist(0, 1),
      title: json['title'] ?? "",
      price: json['price'] ?? 0,
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

Map<String, dynamic> _$ItemModelToMinJson(ItemModel instance) =>
    <String, dynamic>{
      'imageDownloadUrls': instance.imageDownloadUrls,
      'title': instance.title,
      'price': instance.price,
    };
