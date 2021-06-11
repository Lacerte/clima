import 'package:clima_data/models/theme_model.dart';
import 'package:clima_ui/screens/about_screen.dart';
import 'package:clima_ui/state_notifiers/theme_state_notifier.dart';
import 'package:clima_ui/widgets/dark_theme_dialog.dart';
import 'package:clima_ui/widgets/reusable_widgets.dart';
import 'package:clima_ui/widgets/theme_dialog.dart';
import 'package:clima_ui/widgets/unit_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SettingScreen extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final theme =
        useProvider(themeStateNotifierProvider.select((state) => state.theme));

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            }),
        title: Text(
          'Settings',
          style: Theme.of(context).appBarTheme.textTheme.subtitle1,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const SettingsHeader(
              title: 'General',
            ),
            SettingsTile(
              title: 'Unit',
              subtitle: 'Metric',
              leading: const Icon(Icons.straighten_outlined),
              onTap: () => showDialog(
                context: context,
                builder: (context) => UnitDialog(),
              ),
            ),
            const SettingsDivider(),
            const SettingsHeader(
              title: 'Interface',
            ),
            SettingsTile(
              title: 'Theme',
              subtitle: () {
                switch (theme) {
                  case ThemeModel.light:
                    return 'Light';

                  case ThemeModel.dark:
                    return 'Dark';

                  default:
                    throw Error();
                }
              }(),
              padding: 80.0,
              onTap: () => showDialog(
                context: context,
                builder: (context) => ThemeDialog(),
              ),
            ),
            /*SettingsTile(
              title: 'Dark theme',
              subtitle: 'Default',
              padding: 80.0,
              onTap: () => showDialog(
                context: context,
                builder: (context) => DarkThemeDialog(),
              ),
            ),*/
            const SettingsDivider(),
            const SettingsHeader(
              title: 'About',
            ),
            SettingsTile(
              title: 'About Clima',
              leading: const Icon(Icons.info_outline),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => AboutScreen(),
                ),
              ),
            ),
            const SettingsDivider(),
          ],
        ),
      ),
    );
  }
}
