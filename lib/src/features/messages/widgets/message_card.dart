import 'package:flutter/material.dart';

import '../models/message.dart';

class MessageCard extends StatelessWidget {
  final Message message;

  const MessageCard(this.message, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(message.username),
      subtitle: Text(message.message),
    );
  }
}
