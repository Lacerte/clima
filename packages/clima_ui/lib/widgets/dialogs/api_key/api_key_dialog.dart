import 'package:clima_core/failure.dart';
import 'package:clima_data/models/api_key_model.dart';
import 'package:clima_ui/state_notifiers/api_key_state_notifier.dart';
import 'package:clima_ui/utilities/snack_bars.dart';
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

    final failure = useState<Failure?>(null);

    ref.listen<Failure?>(
      apiKeyStateNotifierProvider
          .select((state) => state is Error ? state.failure : null),
      (prev, next) {
        if (next != null) {
          failure.value = next;
        }
      },
    );

    ref.listen<ApiKeyState>(apiKeyStateNotifierProvider, (prev, next) {
      if (next is Loaded) {
        Navigator.pop(context);
        showSnackBar(
          context,
          text: 'API key updated successfully.',
          duration: 4,
        );
      }
    });

    final textController =
        useTextEditingController(text: apiKey.isCustom ? apiKey.apiKey : null);

    Future<void> submit() async {
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
          hintText: 'Enter API key',
          hintStyle: TextStyle(
            color: Theme.of(context).textTheme.subtitle2!.color,
          ),
          errorText: () {
            if (failure.value is InvalidApiKey) {
              return "Looks like this is an invalid API key. Please check that it's correct and try again.";
            }
          }(),
        ),
        onEditingComplete: submit,
        errorMaxLines: 3,
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
        ),
      ],
    );
  }
}
