// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chatroom_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatroomModel _$ChatroomFromJson(Map<String, dynamic> json, chatroomKey, reference) => ChatroomModel(
      itemImage: json['itemImage'] ?? "",
      itemTitle: json['itemTitle'] ?? "",
      itemKey: json['itemKey'] ?? "",
      itemAddress: json['itemAddress'] ?? "",
      itemPrice: json['itemPrice'] ?? 0,
      sellerKey: json['sellerKey'] ?? "",
      buyerKey: json['buyerKey'] ?? "",
      sellerImage: json['sellerImage'] ?? "",
      buyerImage: json['buyerImage'] ?? "",
      geoFirePoint: json['geoFirePoint'] == null
          ? GeoFirePoint(0, 0)
          : GeoFirePoint((json['geoFirePoint']['geopoint']).latitude,
              (json['geoFirePoint']['geopoint']).longitude),
      lastMsg: json['lastMsg'] ?? "",
      lastMsgTime: json['lastMsgTime'] == null
          ? DateTime.now().toUtc()
          : (json['lastMsgTime'] as Timestamp).toDate(),
      lastMsgUserKey: json['lastMsgUserKey'] ?? "",
      chatroomKey: chatroomKey,
      reference: reference,
    );

Map<String, dynamic> _$ChatroomToJson(ChatroomModel instance) =>
    <String, dynamic>{
      'itemImage': instance.itemImage,
      'itemTitle': instance.itemTitle,
      'itemKey': instance.itemKey,
      'itemAddress': instance.itemAddress,
      'itemPrice': instance.itemPrice,
      'sellerKey': instance.sellerKey,
      'buyerKey': instance.buyerKey,
      'sellerImage': instance.sellerImage,
      'buyerImage': instance.buyerImage,
      'geoFirePoint': instance.geoFirePoint.data,
      'lastMsg': instance.lastMsg,
      'lastMsgTime': instance.lastMsgTime,
      'lastMsgUserKey': instance.lastMsgUserKey,
      'chatroomKey': instance.chatroomKey,
    };
