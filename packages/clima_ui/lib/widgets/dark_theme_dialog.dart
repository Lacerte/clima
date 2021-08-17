import 'package:clima_data/models/dark_theme_model.dart';
import 'package:clima_ui/state_notifiers/theme_state_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DarkThemeDialog extends HookWidget {
  static const _dialogOptions = {
    'Default': DarkThemeModel.darkGrey,
    'Black': DarkThemeModel.black,
  };

  @override
  Widget build(BuildContext context) {
    final themeStateNotifier = useProvider(themeStateNotifierProvider.notifier);
    final darkTheme = useProvider(
        themeStateNotifierProvider.select((state) => state.darkTheme));

    final localizations = AppLocalizations.of(context)!;

    final radios = [
      for (final entry in _dialogOptions.entries)
        RadioListTile<DarkThemeModel>(
          title: Text(
            entry.key.toString(),
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
        localizations.darkTheme,
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
