// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatModel _$ChatModelFromJson(Map<String, dynamic> json, chatKey, reference) =>
    ChatModel(
      msg: json['msg'] ?? "",
      createDate: json['createDate'] ?? DateTime.now(),
      userKey: json['userKey'] ?? "",
      reference: reference,
    );

Map<String, dynamic> _$ChatModelToJson(ChatModel instance) => <String, dynamic>{
      'chatKey': instance.chatKey,
      'msg': instance.msg,
      'createDate': instance.createDate,
      'userKey': instance.userKey,
      'reference': instance.reference,
    };
