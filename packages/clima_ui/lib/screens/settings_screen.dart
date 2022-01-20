/*
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

import 'package:clima_data/models/dark_theme_model.dart';
import 'package:clima_data/models/theme_model.dart';
import 'package:clima_ui/screens/about_screen.dart';
import 'package:clima_ui/state_notifiers/theme_state_notifier.dart';
import 'package:clima_ui/widgets/dialogs/api_key_dialog.dart';
import 'package:clima_ui/widgets/dialogs/dark_theme_dialog.dart';
import 'package:clima_ui/widgets/dialogs/theme_dialog.dart';
import 'package:clima_ui/widgets/settings/settings_divider.dart';
import 'package:clima_ui/widgets/settings/settings_header.dart';
import 'package:clima_ui/widgets/settings/settings_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SettingScreen extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme =
        ref.watch(themeStateNotifierProvider.select((state) => state.theme));
    final darkTheme = ref.watch(
      themeStateNotifierProvider.select((state) => state.darkTheme),
    );
    final textFieldController = useTextEditingController();

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
            /*const SettingsHeader(
              title: 'General',
            ),
            SettingsTile(
              title: 'Unit',
              subtitle: 'Metric',
              leading: Icon(
                Icons.straighten_outlined,
                color: Theme.of(context).iconTheme.color,
              ),
              onTap: () => showDialog(
                context: context,
                builder: (context) => UnitDialog(),
              ),
            ),
            const SettingsDivider(),
	    */
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
            const SettingsHeader(
              title: 'API Key',
            ),
            SettingsTile(
              title: 'Enter API Key',
              subtitle: 'No API Key provided',
              leading: Icon(
                Icons.keyboard_outlined,
                color: Theme.of(context).iconTheme.color,
              ),
              onTap: () async {
                await showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      contentPadding: const EdgeInsets.all(16.0),
                      content: TextFormField(
                        controller: textFieldController,
                        cursorColor: Theme.of(context).colorScheme.secondary,
                        autofocus: true,
                        decoration: InputDecoration(
                          focusColor: Theme.of(context).colorScheme.secondary,
                          hintText: 'Enter API Key',
                          hintStyle: TextStyle(
                            color: Theme.of(context).textTheme.subtitle2!.color,
                          ),
                        ),
                        onEditingComplete: () {},
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
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            'SAVE',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                          ),
                        )
                      ],
                    );
                  },
                );
              },
            ),
            SettingsTile(
              title: 'Reset API Key',
              leading: Icon(
                Icons.restore_outlined,
                color: Theme.of(context).iconTheme.color,
              ),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
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
                          onPressed: () {
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
                  },
                );
              },
            ),
            SettingsTile(
              title: 'Learn More',
              leading: Icon(
                Icons.launch_outlined,
                color: Theme.of(context).iconTheme.color,
              ),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return const ApiKeyDialog();
                  },
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
