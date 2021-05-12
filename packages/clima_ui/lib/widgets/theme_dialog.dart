import 'package:clima_data/models/theme_model.dart';
import 'package:clima_ui/state_notifiers/theme_state_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod/riverpod.dart';

class ThemeDialog extends ConsumerWidget {
  static const _dialogOptions = {
    'Dark': ThemeModel.dark,
    'Light': ThemeModel.light,
  };

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final themeStateNotifier = watch(themeStateNotifierProvider.notifier);

    final theme = watch(themeProvider);

    final radios = [
      for (final entry in _dialogOptions.entries)
        RadioListTile<ThemeModel>(
          title: Text(
            entry.key.toString(),
            style: TextStyle(
              color: Theme.of(context).textTheme.subtitle1.color,
            ),
          ),
          value: entry.value,
          groupValue: theme,
          onChanged: (newValue) async {
            await themeStateNotifier.setTheme(newValue);
            Navigator.pop(context);
          },
        )
    ];

    return SimpleDialog(
      title: Text(
        'Theme',
        style: TextStyle(
          color: Theme.of(context).textTheme.subtitle1.color,
        ),
      ),
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: radios,
        ),
      ],
    );
  }
}
