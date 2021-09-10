import 'package:clima_ui/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

//TODO: Add humidity and play around with flex and padding values

class DayTile extends HookWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ///TODO: Add day
          Text(
            '',
            style: TextStyle(
              fontSize:
                  MediaQuery.of(context).size.shortestSide < kTabletBreakpoint
                      ? 15.sp
                      : 10.sp,
              color: Theme.of(context).textTheme.subtitle1!.color,
              fontWeight: FontWeight.bold,
            ),
          ),

          ///TODO: Add weather icon
          SvgPicture.asset(
            '',
            height: 6.h,
          ),
          Row(
            children: [
              Icon(
                Icons.invert_colors,
                color: Theme.of(context).textTheme.subtitle2!.color,
                size:
                    MediaQuery.of(context).size.shortestSide < kTabletBreakpoint
                        ? 15.sp
                        : 10.sp,
              ),

              ///TODO: Add rain chance
              Text(
                '',
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.shortestSide <
                          kTabletBreakpoint
                      ? 15.sp
                      : 10.sp,
                  color: Theme.of(context).textTheme.subtitle2!.color,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(right: 4.w),

                ///TODO: Add max temp
                child: Text(
                  '',
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.shortestSide <
                            kTabletBreakpoint
                        ? 15.sp
                        : 10.sp,
                    color: Theme.of(context).textTheme.subtitle1!.color,
                  ),
                ),
              ),

              ///TODO: Add min temp
              Text(
                '',
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.shortestSide <
                          kTabletBreakpoint
                      ? 15.sp
                      : 10.sp,
                  color: Theme.of(context).textTheme.subtitle2!.color,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
