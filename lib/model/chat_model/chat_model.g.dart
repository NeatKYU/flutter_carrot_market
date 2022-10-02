// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatModel _$ChatModelFromJson(Map<String, dynamic> json, chatKey, reference) =>
    ChatModel(
      msg: json['msg'] ?? "",
      createDate: json['createDate'] == null
          ? DateTime.now().toUtc()
          : (json['createDate'] as Timestamp).toDate(),
      userKey: json['userKey'] ?? "",
      reference: reference,
    );

Map<String, dynamic> _$ChatModelToJson(ChatModel instance) => <String, dynamic>{
      'msg': instance.msg,
      'createDate': instance.createDate,
      'userKey': instance.userKey,
    };
