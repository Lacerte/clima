/*
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

const kTabletBreakpoint = 600.0;

TextStyle kSubtitle1TextStyle(BuildContext context) => TextStyle(
      color: Theme.of(context).textTheme.subtitle1!.color,
      fontSize: MediaQuery.of(context).size.shortestSide < kTabletBreakpoint
          ? 11.sp
          : 8.sp,
    );

TextStyle kSubtitle2TextStyle(BuildContext context) => TextStyle(
      color: Theme.of(context).textTheme.subtitle2!.color,
      fontSize: MediaQuery.of(context).size.shortestSide < kTabletBreakpoint
          ? 11.sp
          : 8.sp,
    );

double kIconSize(BuildContext context) =>
    MediaQuery.of(context).size.shortestSide < kTabletBreakpoint ? 11.sp : 8.sp;

TextStyle kAdditionalInfoTileTitle(BuildContext context) => TextStyle(
      color: Theme.of(context).textTheme.subtitle2!.color,
      fontSize: MediaQuery.of(context).size.shortestSide < kTabletBreakpoint
          ? 11.sp
          : 8.sp,
    );

TextStyle kAdditionalInfoTileValue(BuildContext context) => TextStyle(
      color: Theme.of(context).textTheme.subtitle1!.color,
      fontSize: MediaQuery.of(context).size.shortestSide < kTabletBreakpoint
          ? 15.sp
          : 10.sp,
    );
