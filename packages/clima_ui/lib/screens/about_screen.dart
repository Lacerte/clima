import 'package:clima_ui/widgets/reusable_widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:package_info/package_info.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          appLocalizations.aboutClima,
          style: Theme.of(context).appBarTheme.textTheme!.subtitle1,
        ),
        leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SettingsHeader(
              title: appLocalizations.information,
            ),
            SettingsTile(
              title: appLocalizations.changelog,
              subtitle: 'Version 2.0',
              leading: Icon(
                Icons.new_releases_outlined,
                color: Theme.of(context).iconTheme.color,
              ),
              onTap: () => launch(
                'https://github.com/CentaurusApps/clima/tree/master/fastlane/metadata/android/en-US/changelogs',
              ),
            ),
            SettingsTile(
              title: appLocalizations.donate,
              subtitle: appLocalizations.donateTileSubtitle,
              leading: Icon(
                Icons.local_library_outlined,
                color: Theme.of(context).iconTheme.color,
              ),
              onTap: () => launch(
                'https://liberapay.com/CentaurusApps/donate',
              ),
            ),
            SettingsTile(
              title: appLocalizations.libraries,
              subtitle: appLocalizations.librariesTileSubtitle,
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
              title: appLocalizations.feedback,
              subtitle: appLocalizations.feedbackTileSubtitle,
              leading: Icon(
                Icons.help_outline,
                color: Theme.of(context).iconTheme.color,
              ),
              onTap: () {
                showGeneralSheet(
                  context,
                  title: appLocalizations.feedback,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SettingsTile(
                        title: appLocalizations.submitIssue,
                        leading: Icon(
                          Icons.bug_report_outlined,
                          color: Theme.of(context).iconTheme.color,
                        ),
                        onTap: () => launch(
                          'https://github.com/CentaurusApps/clima/issues/new',
                        ),
                      ),
                      SettingsTile(
                        title: appLocalizations.contactDeveloper,
                        leading: Icon(
                          Icons.email_outlined,
                          color: Theme.of(context).iconTheme.color,
                        ),
                        onTap: () => launch(
                          'mailto:apps_centaurus@protonmail.com',
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            SettingsTile(
              title: appLocalizations.sourceCode,
              subtitle: appLocalizations.sourceCodeTileSubtitle,
              isThreeLine: true,
              leading: Icon(
                FontAwesomeIcons.github,
                color: Theme.of(context).iconTheme.color,
              ),
              onTap: () => launch(
                'https://github.com/CentaurusApps/clima',
              ),
            ),
            const SettingsDivider(),
          ],
        ),
      ),
    );
  }
}
