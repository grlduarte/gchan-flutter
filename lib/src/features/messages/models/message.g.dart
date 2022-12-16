// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Message _$MessageFromJson(Map<String, dynamic> json) => Message(
      id: json['id'] as int?,
      username: json['username'] as String,
      subject: json['subject'] as String,
      message: json['message'] as String,
      imageUrl: json['imageurl'] as String?,
      giphyUrl: json['giphyurl'] as String?,
      createdAt: json['created'] == null
          ? null
          : DateTime.parse(json['created'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      deleted: json['deleted'] as bool? ?? false,
    );

Map<String, dynamic> _$MessageToJson(Message instance) {
  final val = <String, dynamic>{
    'username': instance.username,
    'subject': instance.subject,
    'message': instance.message,
    'imageurl': instance.imageUrl,
    'giphyurl': instance.giphyUrl,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('created', instance.createdAt?.toIso8601String());
  writeNotNull('updated_at', instance.updatedAt?.toIso8601String());
  val['deleted'] = instance.deleted;
  return val;
}
