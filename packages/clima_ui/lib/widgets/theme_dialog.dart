import 'package:clima_ui/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod/riverpod.dart';

enum AppTheme { dark, light }

final themeProvider = StateProvider((ref) => AppTheme.light);

class ThemeDialog extends ConsumerWidget {
  static const _dialogOptions = {
    'Dark': AppTheme.dark,
    'Light': AppTheme.light,
  };

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final theme = watch(themeProvider);
    final _themeState = watch(themeStateNotifier);

    final radios = [
      for (final entry in _dialogOptions.entries)
        RadioListTile<AppTheme>(
          title: Text(
            entry.key.toString(),
            style: TextStyle(
              color: Theme.of(context).textTheme.subtitle1.color,
            ),
          ),
          value: entry.value,
          groupValue: theme.state,
          onChanged: (newValue) {
            theme.state = newValue;
            if (entry.value == AppTheme.dark) {
              _themeState.setDarkTheme();
            } else if (entry.value == AppTheme.light) {
              _themeState.setLightTheme();
            }
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
