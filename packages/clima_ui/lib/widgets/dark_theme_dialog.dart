import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod/riverpod.dart';

enum DarkThemeType { darkGrey, black }

final darkThemeProvider = StateProvider((ref) => DarkThemeType.darkGrey);

class DarkThemeDialog extends ConsumerWidget {
  static const _dialogOptions = {
    'Default': DarkThemeType.darkGrey,
    'Black': DarkThemeType.black,
  };

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final darkTheme = watch(darkThemeProvider);

    final radios = [
      for (final entry in _dialogOptions.entries)
        RadioListTile<DarkThemeType>(
          title: Text(
            entry.key.toString(),
            style: TextStyle(
              color: Theme.of(context).textTheme.subtitle1.color,
            ),
          ),
          value: entry.value,
          groupValue: darkTheme.state,
          onChanged: (newValue) {
            darkTheme.state = newValue;
            Navigator.pop(context);
          },
        )
    ];

    return SimpleDialog(
      title: Text(
        'Dark theme',
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
