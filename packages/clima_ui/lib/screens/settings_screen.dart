/*
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

import 'package:clima_data/models/dark_theme_model.dart';
import 'package:clima_data/models/theme_model.dart';
import 'package:clima_domain/entities/unit_system.dart';
import 'package:clima_ui/screens/about_screen.dart';
import 'package:clima_ui/state_notifiers/api_key_state_notifier.dart' as a;
import 'package:clima_ui/state_notifiers/theme_state_notifier.dart';
import 'package:clima_ui/state_notifiers/unit_system_state_notifier.dart'
    hide Error;
import 'package:clima_ui/widgets/dialogs/api_key/api_key_dialog.dart';
import 'package:clima_ui/widgets/dialogs/api_key/api_key_info_dialog.dart';
import 'package:clima_ui/widgets/dialogs/api_key/api_key_reset_dialog.dart';
import 'package:clima_ui/widgets/dialogs/dark_theme_dialog.dart';
import 'package:clima_ui/widgets/dialogs/theme_dialog.dart';
import 'package:clima_ui/widgets/dialogs/unit_system_dialog.dart';
import 'package:clima_ui/widgets/settings/settings_divider.dart';
import 'package:clima_ui/widgets/settings/settings_header.dart';
import 'package:clima_ui/widgets/settings/settings_tile.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SettingScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme =
        ref.watch(themeStateNotifierProvider.select((state) => state.theme));
    final darkTheme = ref.watch(
      themeStateNotifierProvider.select((state) => state.darkTheme),
    );
    final apiKey = ref
        .watch(a.apiKeyStateNotifierProvider.select((state) => state.apiKey!));

    final unitSystem = ref.watch(
      unitSystemStateNotifierProvider.select((state) => state.unitSystem!),
    );

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          'Settings',
          style: TextStyle(
            color: Theme.of(context).appBarTheme.titleTextStyle!.color,
            fontSize: Theme.of(context).textTheme.headline6!.fontSize,
          ),
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
              title: 'Unit system',
              subtitle: () {
                switch (unitSystem) {
                  case UnitSystem.metric:
                    return 'Metric';

                  case UnitSystem.imperial:
                    return 'Imperial';
                }
              }(),
              leading: Icon(
                Icons.straighten_outlined,
                color: Theme.of(context).iconTheme.color,
              ),
              onTap: () => showDialog(
                context: context,
                builder: (context) => UnitSystemDialog(),
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

                  case ThemeModel.systemDefault:
                    return 'System default';

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
            SettingsTile(
              title: 'Dark theme',
              subtitle: () {
                switch (darkTheme) {
                  case DarkThemeModel.darkGrey:
                    return 'Default';

                  case DarkThemeModel.black:
                    return 'Black';

                  default:
                    throw Error();
                }
              }(),
              padding: 80.0,
              onTap: () => showDialog(
                context: context,
                builder: (context) => DarkThemeDialog(),
              ),
            ),
            const SettingsDivider(),
            const SettingsHeader(title: 'API key'),
            SettingsTile(
              title: 'API key',
              subtitle: apiKey.isCustom
                  ? 'Currently using custom API key'
                  : 'Currently using default API key (not recommended)',
              leading: Icon(
                Icons.keyboard_outlined,
                color: Theme.of(context).iconTheme.color,
              ),
              onTap: () async {
                await showDialog(
                  context: context,
                  builder: (context) => const ApiKeyDialog(),
                );
              },
            ),
            SettingsTile(
              title: 'Reset API key',
              leading: Icon(
                Icons.restore_outlined,
                color: Theme.of(context).iconTheme.color,
              ),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => const ApiKeyResetDialog(),
                );
              },
            ),
            SettingsTile(
              title: 'Learn more',
              leading: Icon(
                Icons.launch_outlined,
                color: Theme.of(context).iconTheme.color,
              ),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => const ApiKeyInfoDialog(),
                );
              },
            ),
            const SettingsDivider(),
            const SettingsHeader(
              title: 'About',
            ),
            SettingsTile(
              title: 'About Clima',
              leading: Icon(
                Icons.info_outline,
                color: Theme.of(context).iconTheme.color,
              ),
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
