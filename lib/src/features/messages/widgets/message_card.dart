import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

import '../models/message.dart';

class MessageCard extends StatelessWidget {
  final Message message;

  const MessageCard(this.message, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          _MessageImage(
            imageUrl: message.imageUrl,
            giphyUrl: message.giphyUrl,
          ),
          _MessageSubject(message.subject),
          _MessageId(message.id!),
          _MessageAuthor(message.username),
          _MessageContent(message.message),
          _MessageCreationDate(message.createdAt!),
        ],
      ),
    );
  }
}

class _MessageImage extends StatelessWidget {
  final String? imageUrl;
  final String? giphyUrl;

  const _MessageImage({this.imageUrl, this.giphyUrl});

  @override
  Widget build(BuildContext context) {
    // TODO: determine which one has preference
    String? url = imageUrl ?? giphyUrl;

    if (url != null) {
      return Padding(
        padding: const EdgeInsets.all(4.0),
        child: Image.network(
          url,
          loadingBuilder: (_, child, progress) {
            if (progress == null) return child;

            double loaded = progress.cumulativeBytesLoaded.toDouble();
            double? expected = progress.expectedTotalBytes?.toDouble();
            double? progressValue =
                (expected == null) ? null : loaded / expected;

            return SizedBox(
              height: 128.0,
              child: Center(
                child: CircularProgressIndicator(value: progressValue),
              ),
            );
          },
        ),
      );
    }

    return const SizedBox.shrink();
  }
}

class _MessageSubject extends StatelessWidget {
  final String? subject;

  const _MessageSubject(this.subject);

  @override
  Widget build(BuildContext context) {
    if (subject == null) return const SizedBox.shrink();

    return Container(
      alignment: Alignment.centerLeft,
      child: Text(
        subject!,
        style: Theme.of(context).textTheme.titleLarge,
      ),
    );
  }
}

class _MessageId extends StatelessWidget {
  final int id;

  const _MessageId(this.id);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Text(
        '#$id',
        style: Theme.of(context).textTheme.labelMedium,
      ),
    );
  }
}

class _MessageAuthor extends StatelessWidget {
  final String username;

  const _MessageAuthor(this.username);

  @override
  Widget build(BuildContext context) {
    AppLocalizations l = AppLocalizations.of(context)!;

    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.all(8.0),
      child: Text(
        '${l.by}: $username',
        style: Theme.of(context).textTheme.labelLarge,
      ),
    );
  }
}

class _MessageContent extends StatelessWidget {
  final String content;

  const _MessageContent(this.content);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Text(
        content,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    );
  }
}

class _MessageCreationDate extends StatelessWidget {
  final DateTime createdAt;

  const _MessageCreationDate(this.createdAt);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.only(top: 16.0),
      child: Text(
        DateFormat.Hm().add_yMd().format(createdAt),
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    );
  }
}
