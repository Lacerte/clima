import 'package:clima_data/models/api_key_model.dart';
import 'package:clima_ui/state_notifiers/api_key_state_notifier.dart';
import 'package:clima_ui/utilities/snack_bars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ApiKeyResetDialog extends ConsumerWidget {
  const ApiKeyResetDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => AlertDialog(
        title: Text(
          'Reset API Key?',
          style: TextStyle(
            color: Theme.of(context).textTheme.subtitle1!.color,
          ),
        ),
        actions: [
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
            onPressed: () async {
              await ref
                  .read(apiKeyStateNotifierProvider.notifier)
                  .setApiKey(const ApiKeyModel.default_());
              showSnackBar(
                context,
                text: 'API key reset successfully.',
                duration: 4,
              );
              Navigator.pop(context);
            },
            child: Text(
              'RESET',
              style: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
          ),
        ],
      );
}
