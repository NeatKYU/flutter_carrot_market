import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:json_annotation/json_annotation.dart';

part 'chatroom_model.g.dart';

@JsonSerializable()
class ChatroomModel {
  late String itemImage;
  late String itemTitle;
  late String itemKey;
  late String itemAddress;
  late int itemPrice;
  late String sellerKey;
  late String buyerKey;
  late String sellerImage;
  late String buyerImage;
  late GeoFirePoint geoFirePoint;
  late String lastMsg;
  late DateTime lastMsgTime;
  late String lastMsgUserKey;
  late String chatroomKey;
  DocumentReference? reference;

  ChatroomModel({
    required this.itemImage,
    required this.itemTitle,
    required this.itemKey,
    required this.itemAddress,
    required this.itemPrice,
    required this.sellerKey,
    required this.buyerKey,
    required this.sellerImage,
    required this.buyerImage,
    required this.geoFirePoint,
    required this.lastMsg,
    required this.lastMsgTime,
    required this.lastMsgUserKey,
    required this.chatroomKey,
    this.reference,
  });

  factory ChatroomModel.fromJson(Map<String, dynamic> json, String chatroomKey,
      DocumentReference reference) {
    return _$ChatroomFromJson(json, chatroomKey, reference);
  }

  factory ChatroomModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    return ChatroomModel.fromJson(
        snapshot.data()!, snapshot.id, snapshot.reference);
  }

  factory ChatroomModel.fromQuerySnapshot(
      QueryDocumentSnapshot<Map<String, dynamic>> snapshot) {
    return ChatroomModel.fromJson(
        snapshot.data(), snapshot.id, snapshot.reference);
  }

  static String createKey(String buyerKey, String itemKey) {
    return '${itemKey}_${buyerKey}';
  }

  Map<String, dynamic> toJson() => _$ChatroomToJson(this);
}
