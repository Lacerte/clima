import 'package:clima_ui/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sizer/sizer.dart';

//TODO: Add humidity and play around with flex and padding values

class DayTile extends HookWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.sp, vertical: 16.sp),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 5,
            child: Text(
              'Sunday',
              style: TextStyle(
                fontSize:
                    MediaQuery.of(context).size.shortestSide < kTabletBreakpoint
                        ? 15.sp
                        : 10.sp,
                color: Theme.of(context).textTheme.subtitle1!.color,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: FaIcon(
              FontAwesomeIcons.sun,
              size: MediaQuery.of(context).size.shortestSide < kTabletBreakpoint
                  ? 17.sp
                  : 13.sp,
              color: Theme.of(context).iconTheme.color,
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              '18°',
              style: TextStyle(
                fontSize:
                    MediaQuery.of(context).size.shortestSide < kTabletBreakpoint
                        ? 15.sp
                        : 10.sp,
                color: Theme.of(context).textTheme.subtitle1!.color,
              ),
            ),
          ),
          Expanded(
            child: Text(
              '11°',
              style: TextStyle(
                fontSize:
                    MediaQuery.of(context).size.shortestSide < kTabletBreakpoint
                        ? 15.sp
                        : 10.sp,
                color: Theme.of(context).textTheme.subtitle2!.color,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
