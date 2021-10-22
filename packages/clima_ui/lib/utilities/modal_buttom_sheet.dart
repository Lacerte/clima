import 'package:clima_ui/themes/clima_theme.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'constants.dart';

Future<void> showGeneralSheet(
  BuildContext context, {
  required Widget child,
  required String title,
}) =>
    showModalBottomSheet(
      backgroundColor: Theme.of(context).dialogBackgroundColor,
      useRootNavigator: true,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8.0),
          topRight: Radius.circular(8.0),
        ),
      ),
      elevation: 2,
      context: context,
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 0.5.h,
            width: MediaQuery.of(context).size.shortestSide < kTabletBreakpoint
                ? 8.w
                : 4.h,
            margin: EdgeInsets.only(top: 2.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2.0),
              color: ClimaTheme.of(context).sheetPillColor,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: 2.h,
              horizontal: 12.w,
            ),
            child: Text(
              title,
              style: kSubtitle1TextStyle(context),
              textAlign: TextAlign.center,
            ),
          ),
          Divider(
            color: Theme.of(context).textTheme.subtitle1!.color!.withAlpha(65),
          ),
          Flexible(
            child: SingleChildScrollView(child: child),
          ),
        ],
      ),
    );
