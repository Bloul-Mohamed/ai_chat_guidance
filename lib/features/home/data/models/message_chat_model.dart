import 'package:json_annotation/json_annotation.dart';
part 'message_chat_model.g.dart';

// create a class MessageChatModel with the fields id, message , from ai or user
@JsonSerializable()
class MessageChatModel {
  final String id;
  final String message;
  final bool fromAI;

  MessageChatModel({
    required this.id,
    required this.message,
    required this.fromAI,
  });

  factory MessageChatModel.fromJson(Map<String, dynamic> json) =>
      _$MessageChatModelFromJson(json);
  Map<String, dynamic> toJson() => _$MessageChatModelToJson(this);
}
