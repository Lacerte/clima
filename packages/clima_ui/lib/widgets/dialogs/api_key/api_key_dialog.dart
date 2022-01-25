import 'package:clima_data/models/api_key_model.dart';
import 'package:clima_ui/state_notifiers/api_key_state_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ApiKeyDialog extends HookConsumerWidget {
  const ApiKeyDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final apiKeyStateNotifier = ref.watch(apiKeyStateNotifierProvider.notifier);
    final apiKey =
        ref.watch(apiKeyStateNotifierProvider.select((state) => state.apiKey!));

    final textController =
        useTextEditingController(text: apiKey.isCustom ? apiKey.apiKey : null);

    Future<void> submit() async {
      Navigator.pop(context);

      final newApiKeyString = textController.text;

      return apiKeyStateNotifier.setApiKey(
        newApiKeyString.isEmpty
            ? const ApiKeyModel.default_()
            : ApiKeyModel.custom(newApiKeyString),
      );
    }

    return AlertDialog(
      contentPadding: const EdgeInsets.all(16.0),
      content: TextField(
        controller: textController,
        cursorColor: Theme.of(context).colorScheme.secondary,
        autofocus: true,
        decoration: InputDecoration(
          focusColor: Theme.of(context).colorScheme.secondary,
          hintText: 'Enter API Key',
          hintStyle: TextStyle(
            color: Theme.of(context).textTheme.subtitle2!.color,
          ),
        ),
        onEditingComplete: submit,
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            'CANCEL',
            style: TextStyle(
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
        ),
        TextButton(
          onPressed: submit,
          child: Text(
            'SAVE',
            style: TextStyle(
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
        )
      ],
    );
  }
}
