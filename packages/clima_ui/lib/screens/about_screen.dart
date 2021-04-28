import 'package:clima_ui/widgets/reusable_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:package_info/package_info.dart';

class AboutScreen extends HookWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            }),
        title: Text(
          'About Clima',
          style: Theme.of(context).appBarTheme.textTheme.subtitle1,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
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
            SettingsTile(
              title: 'Feedback',
              subtitle: 'Bugs and feature requests',
              icon: const Icon(Icons.help_outline),
              onTap: () {
                generalSheet(
                  context,
                  title: 'Feedback',
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      SettingsTile(
                        icon: Icon(Icons.bug_report_outlined),
                        title: 'Submit issue',
                      ),
                      SettingsTile(
                        icon: Icon(Icons.email_outlined),
                        title: 'Contact developer',
                      ),
                    ],
                  ),
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
