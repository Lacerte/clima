/*
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

import 'package:clima_data/models/theme_model.dart';
import 'package:clima_ui/state_notifiers/theme_state_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ThemeDialog extends HookWidget {
  static const _dialogOptions = {
    'Light': ThemeModel.light,
    'Dark': ThemeModel.dark,
    'System default': ThemeModel.systemDefault,
  };

  @override
  Widget build(BuildContext context) {
    final themeStateNotifier = useProvider(themeStateNotifierProvider.notifier);
    final theme =
        useProvider(themeStateNotifierProvider.select((state) => state.theme));

    final radios = [
      for (final entry in _dialogOptions.entries)
        RadioListTile<ThemeModel>(
          title: Text(
            entry.key,
            style: TextStyle(
              color: Theme.of(context).textTheme.subtitle1!.color,
            ),
          ),
          value: entry.value,
          groupValue: theme,
          onChanged: (newValue) async {
            await themeStateNotifier.setTheme(newValue!);
            Navigator.pop(context);
          },
        )
    ];

    return SimpleDialog(
      title: Text(
        'Theme',
        style: TextStyle(
          color: Theme.of(context).textTheme.subtitle1!.color,
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
