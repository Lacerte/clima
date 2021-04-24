import 'package:clima_ui/widgets/dark_theme_dialog.dart';
import 'package:clima_ui/widgets/theme_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class AppearanceScreen extends HookWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            }),
        title: Text(
          'Appearance',
          style: Theme.of(context).appBarTheme.textTheme.subtitle1,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 24),
              child: Container(
                height: 30.0,
                padding: const EdgeInsets.symmetric(horizontal: 80),
                alignment: Alignment.centerLeft,
                child: Text(
                  'Interface',
                  style: Theme.of(context).textTheme.bodyText1.copyWith(
                        color: Theme.of(context).accentColor,
                      ),
                ),
              ),
            ),
            ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 80.0),
              title: Text(
                'Theme',
                style: TextStyle(
                  color: Theme.of(context).textTheme.subtitle1.color,
                ),
              ),
              subtitle: Text(
                'System default',
                style: TextStyle(
                  color: Theme.of(context).textTheme.subtitle2.color,
                ),
              ),
              onTap: () => showDialog(
                context: context,
                builder: (context) => ThemeDialog(),
              ),
            ),
            ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 80.0),
              title: Text(
                'Dark theme',
                style: TextStyle(
                  color: Theme.of(context).textTheme.subtitle1.color,
                ),
              ),
              subtitle: Text(
                'Default',
                style: TextStyle(
                  color: Theme.of(context).textTheme.subtitle2.color,
                ),
              ),
              onTap: () => showDialog(
                context: context,
                builder: (context) => DarkThemeDialog(),
              ),
            ),
            Divider(
              height: 1,
              color: Theme.of(context).textTheme.subtitle1.color.withAlpha(65),
            ),
          ],
        ),
      ),
    );
  }
}
