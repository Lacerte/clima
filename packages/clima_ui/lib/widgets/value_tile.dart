/* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/. */

import 'package:auto_size_text/auto_size_text.dart';
import 'package:clima_ui/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

/// General utility widget used to render a cell divided into three rows
/// First row displays [label]
/// second row displays [iconData]
/// third row displays [value]
class ValueTile extends StatelessWidget {
  const ValueTile(this.label, this.value, {Key? key}) : super(key: key);

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: AutoSizeText(
            label,
            maxLines: 1,
            style: TextStyle(
              fontSize:
                  MediaQuery.of(context).size.shortestSide < kTabletBreakpoint
                      ? 11.sp
                      : 8.sp,
              color: Theme.of(context).textTheme.subtitle2!.color,
            ),
          ),
        ),
        AutoSizeText(
          value,
          style: TextStyle(
            fontSize:
                MediaQuery.of(context).size.shortestSide < kTabletBreakpoint
                    ? 11.sp
                    : 8.sp,
            color: Theme.of(context).textTheme.subtitle1!.color,
          ),
        ),
      ],
    );
  }
}
