import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../models/message.dart';
import '../messages_service.dart';

import '../widgets/message_card.dart';

class MessagesView extends StatelessWidget {
  const MessagesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.appTitle),
      ),
      body: const _MessagesList(),
    );
  }
}

/// A lazy loading list to display gchan messages
class _MessagesList extends StatefulWidget {
  const _MessagesList();

  @override
  _MessagesListState createState() => _MessagesListState();
}

class _MessagesListState extends State<_MessagesList> {
  /// Stores the messages received by the server.
  List<Message> messages = [];

  /// Indicates how many pages are loaded so far.
  int pageNumber = 0;

  /// Number of posts per request.
  final int messagesPerPage = 15;

  /// Sets when to call [fetchData].
  final int nextPageTrigger = 3;

  /// Whether there is more data to fetch.
  bool isLastPage = false;

  /// Loading state of the widget.
  bool isLoading = true;

  /// Whether there were errors while fetching the data.
  bool hasError = false;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    if (isLastPage) return;

    try {
      List<Message> newMessages = await MessagesService.getMessages(
        offset: pageNumber * messagesPerPage,
      );

      setState(() {
        isLoading = false;
        hasError = false;
        isLastPage = (newMessages.length < messagesPerPage);
        messages.addAll(newMessages);
        pageNumber += 1;
      });
    } catch (e) {
      debugPrint(e.toString());
      setState(() {
        isLoading = false;
        hasError = true;
      });
    }
  }

  void retryFetch({setLoading = false}) {
    setState(() {
      if (setLoading) isLoading = true;
      hasError = false;
      fetchData();
    });
  }

  @override
  Widget build(BuildContext context) {
    if (messages.isEmpty) {
      if (isLoading) {
        return const Center(child: CircularProgressIndicator());
      } else if (hasError) {
        return Center(
          child: ErrorTile(onRetry: () => retryFetch(setLoading: true)),
        );
      }

      return Center(child: Text('0 ${AppLocalizations.of(context)!.messages}'));
    }

    return ListView.separated(
      itemCount: messages.length + (isLastPage ? 0 : 1),
      separatorBuilder: (_, __) => const Divider(),
      itemBuilder: (_, index) {
        if (index == (messages.length - nextPageTrigger)) {
          fetchData();
        }

        if (index == messages.length) {
          if (hasError) {
            return ErrorTile(onRetry: retryFetch);
          }

          return const LoadingTile();
        }

        return MessageCard(messages[index]);
      },
    );
  }
}

class LoadingTile extends StatelessWidget {
  const LoadingTile({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Center(child: CircularProgressIndicator()),
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
