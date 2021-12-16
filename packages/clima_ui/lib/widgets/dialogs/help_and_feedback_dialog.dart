/*
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

import 'package:clima_ui/widgets/settings/settings_tile.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpAndFeedbackDialog extends StatelessWidget {
  const HelpAndFeedbackDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text(
        'Help & Feedback',
        style: TextStyle(
          color: Theme.of(context).textTheme.subtitle1!.color,
        ),
      ),
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SettingsTile(
              title: 'Submit request',
              leading: const Icon(FontAwesomeIcons.github),
              onTap: () => launch(
                'https://github.com/lacerte/clima/issues/new',
              ),
            ),
            SettingsTile(
              title: 'Contact developer',
              leading: FaIcon(
                Icons.email_outlined,
                color: Theme.of(context).iconTheme.color,
              ),
              onTap: () => launch(
                'mailto:lacerte@protonmail.com',
              ),
            ),
          ],
        ),
      ],
    );
  }
}
