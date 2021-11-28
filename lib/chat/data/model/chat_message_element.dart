import 'package:json_annotation/json_annotation.dart';

part 'chat_message_element.g.dart';

@JsonSerializable()
class ChatMessageElement {
  ChatMessageElement({
    required this.author,
    required this.message,
  });

  String author;
  String message;

  factory ChatMessageElement.fromJson(Map<String, dynamic> json) => _$ChatMessageElementFromJson(json);
  Map<String, dynamic> toJson() => _$ChatMessageElementToJson(this);
}