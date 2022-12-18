import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../messages_service.dart';
import '../models/message.dart';

import '../widgets/message_card.dart';

class MessageDetailView extends StatelessWidget {
  final int messageId;
  final Message? messageData;

  const MessageDetailView({
    required this.messageId,
    this.messageData,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Respostas do #$messageId'),
      ),
      body: _MessageDetail(
        messageId: messageId,
        messageData: messageData,
      ),
    );
  }
}

class _MessageDetail extends StatefulWidget {
  final int messageId;
  final Message? messageData;

  const _MessageDetail({
    required this.messageId,
    this.messageData,
  });

  @override
  _MessageDetailState createState() => _MessageDetailState();
}

class _MessageDetailState extends State<_MessageDetail> {
  Message? messageData;
  bool isLoading = true;
  bool hasError = false;

  @override
  void initState() {
    super.initState();
    loadMessageData();
  }

  void loadMessageData() async {
    try {
      Message? loadedMessage = widget.messageData;
      loadedMessage ??= await MessagesService.getMessageById(widget.messageId);
      setState(() {
        messageData = loadedMessage;
        isLoading = false;
        hasError = false;
      });
    } catch (e) {
      debugPrint(e.toString());
      setState(() {
        isLoading = false;
        hasError = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) return const Center(child: CircularProgressIndicator());

    if (hasError) return Center(child: ErrorTile(onRetry: loadMessageData));

    if (messageData == null) {
      return const Center(child: Text('Mensagem não encontrada'));
    }

    return SingleChildScrollView(
      child: MessageCard(messageData!),
    );
  }
}

class ErrorTile extends StatelessWidget {
  final VoidCallback? onRetry;

  const ErrorTile({
    this.onRetry,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    AppLocalizations l = AppLocalizations.of(context)!;

    return TextButton.icon(
      onPressed: onRetry,
      label: Text(l.tryAgain),
      icon: const Icon(Icons.replay),
    );
  }
}
