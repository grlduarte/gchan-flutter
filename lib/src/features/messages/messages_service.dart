import 'dart:convert';

import 'package:http/http.dart';
import 'package:gchan_flutter/server_config.dart';

import 'models/message.dart';

const kMessagesPath = 'messages';

class MessagesService {
  static Uri messagesUrl({Map<String, String>? queryParameters}) {
    return Uri(
      scheme: kServerSchema,
      host: kServerHost,
      port: kServerPort,
      path: kMessagesPath,
      queryParameters: queryParameters,
    );
  }

  static Future<List<Message>> getAllMessages() => getMessages();

  static Future<List<Message>> getMessages({int? offset}) async {
    Map<String, String> queryParameters = <String, String>{
      if (offset != null) 'offset': offset.toString(),
    };

    Response response =
        await get(messagesUrl(queryParameters: queryParameters));

    if (response.statusCode == 200) {
      List<dynamic> results = jsonDecode(response.body)['results'];
      return results.map((message) => Message.fromJson(message)).toList();
    }

    throw Exception(response.statusCode);
  }
}
