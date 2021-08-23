import 'package:auto_size_text/auto_size_text.dart';
import 'package:clima_data/models/dark_theme_model.dart';
import 'package:clima_data/models/theme_model.dart';
import 'package:clima_ui/screens/about_screen.dart';
import 'package:clima_ui/state_notifiers/theme_state_notifier.dart';
import 'package:clima_ui/widgets/dark_theme_dialog.dart';
import 'package:clima_ui/widgets/reusable_widgets.dart';
import 'package:clima_ui/widgets/theme_dialog.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingScreen extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final theme =
        useProvider(themeStateNotifierProvider.select((state) => state.theme));
    final darkTheme = useProvider(
        themeStateNotifierProvider.select((state) => state.darkTheme));
    final TextEditingController _textFieldController = TextEditingController();

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
                          controller: _textFieldController,
                          cursorColor: Theme.of(context).accentColor,
                          autofocus: true,
                          decoration: InputDecoration(
                            focusColor: Theme.of(context).accentColor,
                            hintText: 'Enter API Key',
                            hintStyle: TextStyle(
                              color:
                                  Theme.of(context).textTheme.subtitle2!.color,
                            ),
                          ),
                          onEditingComplete: () {},
                        ),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: AutoSizeText(
                              'CANCEL',
                              style: TextStyle(
                                color: Theme.of(context).accentColor,
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: AutoSizeText(
                              'SAVE',
                              style: TextStyle(
                                color: Theme.of(context).accentColor,
                              ),
                            ),
                          )
                        ],
                      );
                    });
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
                        title: AutoSizeText(
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
                            child: AutoSizeText(
                              'CANCEL',
                              style: TextStyle(
                                color: Theme.of(context).accentColor,
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: AutoSizeText(
                              'RESET',
                              style: TextStyle(
                                color: Theme.of(context).accentColor,
                              ),
                            ),
                          ),
                        ],
                      );
                    });
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
                      final textSpanStyle = TextStyle(
                        color: Theme.of(context).textTheme.subtitle1!.color,
                      );
                      return SimpleDialog(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                AutoSizeText.rich(
                                  TextSpan(
                                    text:
                                        'Clima receives data from the free service of ',
                                    style: textSpanStyle,
                                    children: [
                                      TextSpan(
                                        text: 'OpenWeatherMap',
                                        style: TextStyle(
                                          color: Theme.of(context).accentColor,
                                        ),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () => launch(
                                              'https://openweathermap.org/price'),
                                      ),
                                      TextSpan(
                                        text:
                                            '. This service is limited to 1000 calls per day. You could register your own API key for free to get your own 1000 calls. Otherwise, calls are shared between all users of Clima.',
                                        style: textSpanStyle,
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      );
                    });
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
