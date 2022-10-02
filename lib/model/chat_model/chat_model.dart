import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'chat_model.g.dart';

@JsonSerializable()
class ChatModel {
  late String chatKey;
  late String msg;
  late String createDate;
  late String userKey;
  DocumentReference? reference;

  ChatModel({
    required this.chatKey,
    required this.msg,
    required this.createDate,
    required this.userKey,
    this.reference,
  });

  factory ChatModel.fromJson(
      Map<String, dynamic> json, String chatKey, DocumentReference reference) {
    return _$ChatModelFromJson(json, chatKey, reference);
  }

  factory ChatModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    return ChatModel.fromJson(
        snapshot.data()!, snapshot.id, snapshot.reference);
  }

  factory ChatModel.fromQuerySnapshot(
      QueryDocumentSnapshot<Map<String, dynamic>> snapshot) {
    return ChatModel.fromJson(snapshot.data(), snapshot.id, snapshot.reference);
  }

  Map<String, dynamic> toJson() => _$ChatModelToJson(this);
}
