import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../models/message.dart';
import '../messages_service.dart';

void navigateToNewMessageView(BuildContext context) {
  Navigator.of(context).push(
    MaterialPageRoute<void>(
      fullscreenDialog: true,
      builder: (_) => const NewMessageView(),
    ),
  );
}

class NewMessageView extends StatelessWidget {
  const NewMessageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const _NewMessageForm(),
    );
  }
}

class _NewMessageForm extends StatefulWidget {
  const _NewMessageForm();

  @override
  State<_NewMessageForm> createState() => _NewMessageFormState();
}

class _NewMessageFormState extends State<_NewMessageForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameKey = GlobalKey<FormFieldState<String>>();
  final _subjectKey = GlobalKey<FormFieldState<String>>();
  final _contentKey = GlobalKey<FormFieldState<String>>();

  void onSubmit() async {
    bool isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) return;

    AppLocalizations labels = AppLocalizations.of(context)!;
    _formKey.currentState?.save();

    String name = _nameKey.currentState?.value ?? labels.anonymous;
    String? subject = (_subjectKey.currentState?.value?.isEmpty ?? true)
        ? null
        : _subjectKey.currentState!.value!;
    String content = _contentKey.currentState?.value ?? '';

    Message message = Message(
      username: name,
      subject: subject ?? '',
      message: content,
    );

    await MessagesService.postNewMessage(message);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            _NameFormField(fieldKey: _nameKey),
            _SubjectFormField(fieldKey: _subjectKey),
            _ContentFormField(fieldKey: _contentKey),
            const SizedBox(height: 16.0),
            _SubmitFormButton(onPressed: onSubmit),
          ],
        ),
      ),
    );
  }
}

class _NameFormField extends StatelessWidget {
  final GlobalKey<FormFieldState<String>> fieldKey;

  const _NameFormField({required this.fieldKey});

  @override
  Widget build(BuildContext context) {
    AppLocalizations labels = AppLocalizations.of(context)!;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        key: fieldKey,
        autocorrect: false,
        initialValue: labels.anonymous,
        decoration: InputDecoration(
          label: Text(labels.name),
          helperText: 'Ski-bi dibby dib yo da dub dub',
        ),
        textInputAction: TextInputAction.next,
      ),
    );
  }
}

class _SubjectFormField extends StatelessWidget {
  final GlobalKey<FormFieldState<String>> fieldKey;

  const _SubjectFormField({required this.fieldKey});

  @override
  Widget build(BuildContext context) {
    AppLocalizations labels = AppLocalizations.of(context)!;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        key: fieldKey,
        initialValue: null,
        decoration: InputDecoration(
          label: Text(labels.subject),
        ),
        textInputAction: TextInputAction.next,
      ),
    );
  }
}

class _ContentFormField extends StatelessWidget {
  final GlobalKey<FormFieldState<String>> fieldKey;

  const _ContentFormField({required this.fieldKey});

  @override
  Widget build(BuildContext context) {
    AppLocalizations labels = AppLocalizations.of(context)!;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
          key: fieldKey,
          initialValue: null,
          maxLines: 8,
          decoration: InputDecoration(
            label: Text(labels.message),
          ),
          validator: (value) {
            if (value?.isEmpty ?? true) {
              return labels.emptyContentValidationMessage;
            }

            return null;
          }),
    );
  }
}

class _SubmitFormButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const _SubmitFormButton({this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(AppLocalizations.of(context)!.post.toUpperCase()),
    );
  }
}
