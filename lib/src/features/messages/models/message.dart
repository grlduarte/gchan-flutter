import 'package:json_annotation/json_annotation.dart';

part 'message.g.dart';

@JsonSerializable()
class Message {
  String username;

  String subject;

  String message;

  @JsonKey(name: 'imageurl')
  String? imageUrl;

  @JsonKey(name: 'giphyurl')
  String? giphyUrl;

  @JsonKey(includeIfNull: false)
  int? id;

  @JsonKey(name: 'created', includeIfNull: false)
  DateTime? createdAt;

  @JsonKey(name: 'updated_at', includeIfNull: false)
  DateTime? updatedAt;

  bool deleted;

  Message({
    this.id,
    required this.username,
    required this.subject,
    required this.message,
    this.imageUrl,
    this.giphyUrl,
    this.createdAt,
    this.updatedAt,
    this.deleted = false,
  });

  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);

  Map<String, dynamic> toJson() => _$MessageToJson(this);
}
