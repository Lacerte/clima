import 'package:clima_ui/widgets/reusable_widgets.dart';
import 'package:clima_ui/widgets/unit_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:package_info/package_info.dart';

import 'appearance_screen.dart';

class SettingScreen extends HookWidget {
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
              title: 'Appearance',
              subtitle: 'Customization of appearance',
              icon: const Icon(Icons.format_paint_outlined),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => AppearanceScreen(),
                ),
              ),
            ),
            SettingsTile(
              title: 'Unit',
              subtitle: 'Metric',
              icon: const Icon(Icons.straighten_outlined),
              onTap: () => showDialog(
                context: context,
                builder: (context) => UnitDialog(),
              ),
            ),
            Divider(
              height: 1,
              color: Theme.of(context).textTheme.subtitle1.color.withAlpha(65),
            ),
            const SettingsHeader(
              title: 'Support',
            ),
            const SettingsTile(
              title: 'Issue tracker',
              icon: Icon(Icons.bug_report_outlined),
            ),
            const SettingsTile(
              title: 'Contact developer',
              icon: Icon(Icons.email_outlined),
            ),
            Divider(
              height: 1,
              color: Theme.of(context).textTheme.subtitle1.color.withAlpha(65),
            ),
            const SettingsHeader(
              title: 'Information',
            ),
            const SettingsTile(
              title: 'Changelog',
              subtitle: 'Version 2.0',
              icon: Icon(Icons.new_releases_outlined),
            ),
            SettingsTile(
              title: 'Libraries',
              subtitle: 'Open-sourced libraries used in the app',
              icon: const Icon(Icons.source_outlined),
              onTap: () async {
                final PackageInfo packageInfo =
                    await PackageInfo.fromPlatform();
                showLicensePage(
                  context: context,
                  applicationName: packageInfo.appName,
                  applicationVersion: packageInfo.version,
                );
              },
            ),
            const SettingsTile(
              title: 'Source code',
              subtitle: 'Clima is free software licensed under the GPLv3',
              icon: Icon(FontAwesomeIcons.github),
            ),
          ],
        ),
      ),
    );
  }
}
