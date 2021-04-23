import 'package:clima_ui/widgets/theme_dialog.dart';
import 'package:clima_ui/widgets/unit_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:package_info/package_info.dart';

enum Settings { theme, unit }

class SettingScreen extends HookWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 1,
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
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 72.0),
            title: Text(
              "What's New",
              style: TextStyle(
                color: Theme.of(context).textTheme.subtitle1.color,
              ),
            ),
            subtitle: Text(
              'Version 1.2',
              style: TextStyle(
                color: Theme.of(context).textTheme.subtitle2.color,
              ),
            ),
          ),
          Divider(
            height: 1,
            color: Theme.of(context).textTheme.subtitle1.color.withAlpha(65),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 24),
            child: Container(
              height: 30.0,
              padding: const EdgeInsets.symmetric(horizontal: 72),
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
            contentPadding: const EdgeInsets.symmetric(horizontal: 72.0),
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
            contentPadding: const EdgeInsets.symmetric(horizontal: 72.0),
            title: Text(
              'Unit',
              style: TextStyle(
                color: Theme.of(context).textTheme.subtitle1.color,
              ),
            ),
            subtitle: Text(
              'Metric',
              style: TextStyle(
                color: Theme.of(context).textTheme.subtitle2.color,
              ),
            ),
            onTap: () => showDialog(
              context: context,
              builder: (context) => UnitDialog(),
            ),
          ),
          Divider(
            height: 1,
            color: Theme.of(context).textTheme.subtitle1.color.withAlpha(65),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 24),
            child: Container(
              height: 30.0,
              padding: const EdgeInsets.symmetric(horizontal: 72),
              alignment: Alignment.centerLeft,
              child: Text(
                'Support',
                style: Theme.of(context).textTheme.bodyText1.copyWith(
                      color: Theme.of(context).accentColor,
                    ),
              ),
            ),
          ),
          ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 72.0),
            title: Text(
              'Issue tracker',
              style: TextStyle(
                color: Theme.of(context).textTheme.subtitle1.color,
              ),
            ),
          ),
          ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 72.0),
            title: Text(
              'Contact developer',
              style: TextStyle(
                color: Theme.of(context).textTheme.subtitle1.color,
              ),
            ),
          ),
          Divider(
            height: 1,
            color: Theme.of(context).textTheme.subtitle1.color.withAlpha(65),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 24),
            child: Container(
              height: 30.0,
              padding: const EdgeInsets.symmetric(horizontal: 72),
              alignment: Alignment.centerLeft,
              child: Text(
                'About',
                style: Theme.of(context).textTheme.bodyText1.copyWith(
                      color: Theme.of(context).accentColor,
                    ),
              ),
            ),
          ),
          ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 72.0),
            title: Text(
              'Source code',
              style: TextStyle(
                color: Theme.of(context).textTheme.subtitle1.color,
              ),
            ),
          ),
          ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 72.0),
            title: Text(
              'Third-party licenses',
              style: TextStyle(
                color: Theme.of(context).textTheme.subtitle1.color,
              ),
            ),
            onTap: () async {
              final PackageInfo packageInfo = await PackageInfo.fromPlatform();
              showLicensePage(
                context: context,
                applicationName: packageInfo.appName,
                applicationVersion: packageInfo.version,
              );
            },
          ),
          Divider(
            height: 1,
            color: Theme.of(context).textTheme.subtitle1.color.withAlpha(65),
          ),
        ],
      ),
    );
  }
}
