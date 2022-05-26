/*
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

import 'package:clima_ui/build_flavor.dart';
import 'package:clima_ui/widgets/dialogs/credits_dialog.dart';
import 'package:clima_ui/widgets/dialogs/help_and_feedback_dialog.dart';
import 'package:clima_ui/widgets/settings/settings_divider.dart';
import 'package:clima_ui/widgets/settings/settings_header.dart';
import 'package:clima_ui/widgets/settings/settings_tile.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:package_info_plus/package_info_plus.dart';
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
              subtitle: 'Version 2.0.1',
              leading: Icon(
                Icons.new_releases_outlined,
                color: Theme.of(context).iconTheme.color,
              ),
              onTap: () => launchUrl(
                Uri.parse(
                  'https://github.com/lacerte/clima/releases/tag/v2.0.1',
                ),
              ),
            ),
            // Google doesn't like donate buttons apparently. Stupid, I know.
            // Example: https://github.com/streetcomplete/StreetComplete/issues/3768
            if (buildFlavor != BuildFlavor.googlePlay)
              SettingsTile(
                title: 'Donate',
                subtitle: 'Support the development of Clima',
                leading: Icon(
                  Icons.local_library_outlined,
                  color: Theme.of(context).iconTheme.color,
                ),
                onTap: () => launchUrl(
                  Uri.parse('https://liberapay.com/lacerte/donate'),
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
                showDialog(
                  context: context,
                  builder: (context) => const HelpAndFeedbackDialog(),
                );
              },
            ),
            SettingsTile(
              title: 'Source code',
              subtitle: 'Clima is free software licensed under the MPL 2.0',
              isThreeLine: true,
              leading: FaIcon(
                FontAwesomeIcons.github,
                color: Theme.of(context).iconTheme.color,
              ),
              onTap: () => launchUrl(
                Uri.parse('https://github.com/lacerte/clima'),
              ),
            ),
            SettingsTile(
              title: 'Credits',
              leading: Icon(
                Icons.attribution_outlined,
                color: Theme.of(context).iconTheme.color,
              ),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return const SimpleDialog(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(16.0),
                          child: CreditsDialog(),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
            const SettingsDivider(),
          ],
        ),
      ),
    );
  }
}
