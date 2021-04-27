import 'package:clima_ui/widgets/reusable_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:package_info/package_info.dart';

class AboutScreen extends HookWidget {
  const AboutScreen({this.title});

  final String title;
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
          title ?? 'About Clima',
          style: Theme.of(context).appBarTheme.textTheme.subtitle1,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const SettingsHeader(
              title: 'Help & feedback',
            ),
            const SettingsTile(
              title: 'Issue tracker',
              icon: Icon(Icons.bug_report_outlined),
            ),
            const SettingsTile(
              title: 'Contact developer',
              icon: Icon(Icons.email_outlined),
            ),
            const SettingsDivider(),
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
              subtitle: 'Open-source libraries used in the app',
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
              isThreeLine: true,
            ),
            const SettingsDivider(),
          ],
        ),
      ),
    );
  }
}
