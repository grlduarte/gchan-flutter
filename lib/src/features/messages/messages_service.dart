import 'dart:convert';

import 'package:http/http.dart';
import 'package:gchan_flutter/server_config.dart';

import 'models/message.dart';

const kMessagesPath = 'messages';

class MessagesService {
  static Uri messagesUrl({
    int? messageId,
    int? offset,
  }) {
    assert((messageId != null && offset == null) ||
        (messageId == null && offset != null) ||
        (messageId == null && offset == null));

    return Uri(
      scheme: kServerSchema,
      host: kServerHost,
      port: kServerPort,
      path: '$kMessagesPath/${(messageId == null) ? '' : messageId}',
      queryParameters: <String, String>{
        if (offset != null) 'offset': offset.toString(),
      },
    );
  }

  static Future<List<Message>> getAllMessages() => getMessages();

  static Future<List<Message>> getMessages({int? offset}) async {
    Response response = await get(messagesUrl(offset: offset));

    if (response.statusCode == 200) {
      List<dynamic> results = jsonDecode(response.body)['results'];
      return results.map((message) => Message.fromJson(message)).toList();
    }

    throw Exception(response.statusCode);
  }

  static Future<Message?> getMessageById(int messageId) async {
    Response response = await get(messagesUrl(messageId: messageId));

    if (response.statusCode == 200) {
      List<dynamic> results = jsonDecode(response.body)['results'];

      if (results.isEmpty) return null;

      return Message.fromJson(results.first);
    }

    throw Exception(response.statusCode);
  }

  //static Future<List<Reply>> getMessageReplies(int messageId) {}
}
