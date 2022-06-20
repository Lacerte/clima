/*
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

import 'package:clima/data/models/dark_theme_model.dart';
import 'package:clima/ui/state_notifiers/theme_state_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DarkThemeDialog extends ConsumerWidget {
  static const _dialogOptions = {
    'Default': DarkThemeModel.darkGrey,
    'Black': DarkThemeModel.black,
  };

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeStateNotifier = ref.watch(themeStateNotifierProvider.notifier);
    final darkTheme = ref.watch(
      themeStateNotifierProvider.select((state) => state.darkTheme),
    );

    final radios = [
      for (final entry in _dialogOptions.entries)
        RadioListTile<DarkThemeModel>(
          title: Text(
            entry.key,
            style: TextStyle(
              color: Theme.of(context).textTheme.subtitle1!.color,
            ),
          ),
          value: entry.value,
          groupValue: darkTheme,
          onChanged: (newValue) {
            themeStateNotifier.setDarkTheme(newValue!);
            Navigator.pop(context);
          },
        )
    ];

    return SimpleDialog(
      title: Text(
        'Dark theme',
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
