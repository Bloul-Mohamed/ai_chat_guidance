import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';
part 'message_chat_model.g.dart';

// create a class MessageChatModel with the fields id with auto generate using uuid package, message , from ai or user
@JsonSerializable()
class MessageChatModel {
  final String id;
  final String message;
  final bool fromAI;

  MessageChatModel({String? id, required this.message, required this.fromAI})
    : id = id ?? const Uuid().v4();

  factory MessageChatModel.fromJson(Map<String, dynamic> json) =>
      _$MessageChatModelFromJson(json);

  Map<String, dynamic> toJson() => _$MessageChatModelToJson(this);
}
