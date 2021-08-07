import 'package:clima_data/models/dark_theme_model.dart';
import 'package:clima_data/models/theme_model.dart';
import 'package:clima_ui/screens/about_screen.dart';
import 'package:clima_ui/state_notifiers/theme_state_notifier.dart';
import 'package:clima_ui/widgets/dark_theme_dialog.dart';
import 'package:clima_ui/widgets/reusable_widgets.dart';
import 'package:clima_ui/widgets/theme_dialog.dart';
// import 'package:clima_ui/widgets/unit_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingScreen extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;

    final theme =
        useProvider(themeStateNotifierProvider.select((state) => state.theme));
    final darkTheme = useProvider(
        themeStateNotifierProvider.select((state) => state.darkTheme));

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            }),
        title: Text(
          appLocalizations.settings,
          style: Theme.of(context).appBarTheme.textTheme!.subtitle1,
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
            SettingsHeader(
              title: appLocalizations.interface,
            ),
            SettingsTile(
              title: appLocalizations.theme,
              subtitle: () {
                switch (theme) {
                  case ThemeModel.light:
                    return appLocalizations.light;

                  case ThemeModel.dark:
                    return appLocalizations.dark;

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
              title: appLocalizations.darkTheme,
              subtitle: () {
                switch (darkTheme) {
                  case DarkThemeModel.darkGrey:
                    return appLocalizations.defaultTheme;

                  case DarkThemeModel.black:
                    return appLocalizations.black;

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
            SettingsHeader(
              title: appLocalizations.about,
            ),
            SettingsTile(
              title: appLocalizations.aboutClima,
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
