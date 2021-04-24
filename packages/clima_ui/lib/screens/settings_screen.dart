import 'package:clima_ui/screens/appearance_screen.dart';
import 'package:clima_ui/widgets/unit_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:package_info/package_info.dart';

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
            Padding(
              padding: const EdgeInsets.only(top: 24),
              child: Container(
                height: 30.0,
                padding: const EdgeInsets.symmetric(horizontal: 80),
                alignment: Alignment.centerLeft,
                child: Text(
                  'Common settings',
                  style: Theme.of(context).textTheme.bodyText1.copyWith(
                        color: Theme.of(context).accentColor,
                      ),
                ),
              ),
            ),
            ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 24.0),
              leading: const Icon(Icons.format_paint_outlined),
              title: Text(
                'Appearance',
                style: TextStyle(
                  color: Theme.of(context).textTheme.subtitle1.color,
                ),
              ),
              subtitle: Text(
                'Customization of appearance',
                style: TextStyle(
                  color: Theme.of(context).textTheme.subtitle2.color,
                ),
              ),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => AppearanceScreen(),
                ),
              ),
            ),
            ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 24.0),
              leading: const Icon(Icons.straighten_outlined),
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
                padding: const EdgeInsets.symmetric(horizontal: 80),
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
              contentPadding: const EdgeInsets.symmetric(horizontal: 24.0),
              leading: const Icon(Icons.bug_report_outlined),
              title: Text(
                'Issue tracker',
                style: TextStyle(
                  color: Theme.of(context).textTheme.subtitle1.color,
                ),
              ),
            ),
            ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 24.0),
              leading: const Icon(Icons.email_outlined),
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
                padding: const EdgeInsets.symmetric(horizontal: 80),
                alignment: Alignment.centerLeft,
                child: Text(
                  'Information',
                  style: Theme.of(context).textTheme.bodyText1.copyWith(
                        color: Theme.of(context).accentColor,
                      ),
                ),
              ),
            ),
            ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 24),
              leading: const Icon(
                Icons.new_releases_outlined,
              ),
              title: Text(
                'Changelog',
                style: TextStyle(
                  color: Theme.of(context).textTheme.subtitle1.color,
                ),
              ),
              subtitle: Text(
                'List of changes made in the latest updates',
                style: TextStyle(
                  color: Theme.of(context).textTheme.subtitle2.color,
                ),
              ),
            ),
            ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 24.0),
              leading: const Icon(Icons.source_outlined),
              title: Text(
                'Libraries',
                style: TextStyle(
                  color: Theme.of(context).textTheme.subtitle1.color,
                ),
              ),
              subtitle: Text(
                'Open-sourced libraries used in the app',
                style: TextStyle(
                  color: Theme.of(context).textTheme.subtitle2.color,
                ),
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
            ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 24),
              leading: const Icon(
                Icons.local_library_outlined,
              ),
              title: Text(
                'Donate',
                style: TextStyle(
                  color: Theme.of(context).textTheme.subtitle1.color,
                ),
              ),
              subtitle: Text(
                'Support the development of Clima',
                style: TextStyle(
                  color: Theme.of(context).textTheme.subtitle2.color,
                ),
              ),
            ),
            ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 24),
              leading: const Icon(
                Icons.translate_outlined,
              ),
              title: Text(
                'Help with localization',
                style: TextStyle(
                  color: Theme.of(context).textTheme.subtitle1.color,
                ),
              ),
              subtitle: Text(
                'Help Clima speak your language',
                style: TextStyle(
                  color: Theme.of(context).textTheme.subtitle2.color,
                ),
              ),
            ),
            ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 24.0),
              leading: const Icon(FontAwesomeIcons.github),
              title: Text(
                'Source code',
                style: TextStyle(
                  color: Theme.of(context).textTheme.subtitle1.color,
                ),
              ),
              subtitle: Text(
                'Clima is libre open-source software, licensed under the GNU General Public License v3.0',
                style: TextStyle(
                  color: Theme.of(context).textTheme.subtitle2.color,
                ),
              ),
            ),
            ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 24.0),
              leading: const Icon(Icons.star_border_outlined),
              title: Text(
                'Rate on Google Play',
                style: TextStyle(
                  color: Theme.of(context).textTheme.subtitle1.color,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
