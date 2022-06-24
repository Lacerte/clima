/*
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

import 'package:clima_ui/screens/settings_screen.dart';
import 'package:clima_ui/widgets/dialogs/help_and_feedback_dialog.dart';
import 'package:flutter/material.dart';

enum Menu { settings, help }

class OverflowMenuButton extends StatelessWidget {
  const OverflowMenuButton({super.key});

  @override
  Widget build(BuildContext context) => PopupMenuButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        offset: const Offset(512.0, -512.0),
        icon: Icon(
          Icons.more_vert,
          color: Theme.of(context).appBarTheme.iconTheme!.color,
        ),
        tooltip: 'More options',
        itemBuilder: (context) => [
          PopupMenuItem(
            value: Menu.settings,
            child: ListTile(
              title: const Text('Settings'),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (context) => SettingScreen(),
                  ),
                );
              },
            ),
          ),
          PopupMenuItem(
            value: Menu.help,
            child: ListTile(
              title: const Text('Help & feedback'),
              onTap: () {
                Navigator.of(context).pop();
                showDialog<void>(
                  context: context,
                  builder: (context) => const HelpAndFeedbackDialog(),
                );
              },
            ),
          ),
        ],
      );
}
