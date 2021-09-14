import 'package:clima_ui/widgets/reusable_widgets.dart';
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          'About Clima',
          style: TextStyle(
            color: Theme.of(context).appBarTheme.titleTextStyle!.color,
            fontSize: Theme.of(context).textTheme.headline6!.fontSize,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const SettingsHeader(
              title: 'Information',
            ),
            SettingsTile(
              title: 'Changelog',
              subtitle: 'Version 2.0',
              leading: Icon(
                Icons.new_releases_outlined,
                color: Theme.of(context).iconTheme.color,
              ),
              onTap: () => launch(
                'https://github.com/lacerte/clima/tree/master/fastlane/metadata/android/en-US/changelogs',
              ),
            ),
            SettingsTile(
              title: 'Donate',
              subtitle: 'Support the development of Clima',
              leading: Icon(
                Icons.local_library_outlined,
                color: Theme.of(context).iconTheme.color,
              ),
              onTap: () => launch(
                'https://liberapay.com/lacerte/donate',
              ),
            ),
            SettingsTile(
              title: 'Libraries',
              subtitle: 'Open-source libraries used in the app',
              leading: Icon(
                Icons.source_outlined,
                color: Theme.of(context).iconTheme.color,
              ),
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
              leading: Icon(
                Icons.help_outline,
                color: Theme.of(context).iconTheme.color,
              ),
              onTap: () {
                showGeneralSheet(
                  context,
                  title: 'Feedback',
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SettingsTile(
                        title: 'Submit issue',
                        leading: Icon(
                          Icons.bug_report_outlined,
                          color: Theme.of(context).iconTheme.color,
                        ),
                        onTap: () => launch(
                          'https://github.com/lacerte/clima/issues/new',
                        ),
                      ),
                      SettingsTile(
                        title: 'Contact developer',
                        leading: Icon(
                          Icons.email_outlined,
                          color: Theme.of(context).iconTheme.color,
                        ),
                        onTap: () => launch(
                          'mailto:lacerte@protonmail.com',
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            SettingsTile(
              title: 'Source code',
              subtitle:
                  'Clima is free software licensed under the 3-clause BSD license',
              isThreeLine: true,
              leading: Icon(
                Icons.code,
                color: Theme.of(context).iconTheme.color,
              ),
              onTap: () => launch(
                'https://github.com/lacerte/clima',
              ),
            ),
            const SettingsDivider(),
          ],
        ),
      ),
    );
  }
}
