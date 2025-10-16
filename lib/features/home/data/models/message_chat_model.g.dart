// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_chat_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageChatModel _$MessageChatModelFromJson(Map<String, dynamic> json) =>
    MessageChatModel(
      id: json['id'] as String?,
      message: json['message'] as String,
      fromAI: json['fromAI'] as bool,
    );

Map<String, dynamic> _$MessageChatModelToJson(MessageChatModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'message': instance.message,
      'fromAI': instance.fromAI,
    };
