import 'package:clima_ui/screens/settings_screen.dart';
import 'package:clima_ui/utilities/modal_buttom_sheet.dart';
import 'package:clima_ui/widgets/settings/settings_tile.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

enum Menu { settings, help }

class OverflowMenuButton extends StatelessWidget {
  const OverflowMenuButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
      offset: const Offset(512.0, -512.0),
      icon: Icon(
        Icons.more_vert,
        color: Theme.of(context).appBarTheme.iconTheme!.color,
      ),
      tooltip: 'More options',
      itemBuilder: (BuildContext context) => <PopupMenuEntry<Menu>>[
        PopupMenuItem<Menu>(
          value: Menu.settings,
          child: ListTile(
            title: const Text('Settings'),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => SettingScreen(),
                ),
              );
            },
          ),
        ),
        PopupMenuItem<Menu>(
          value: Menu.help,
          child: ListTile(
            title: const Text('Help & feedback'),
            onTap: () {
              Navigator.of(context).pop();
              showGeneralSheet(
                context,
                title: 'Help & feedback',
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
        ),
      ],
    );
  }
}
