import 'package:clima_core/failure.dart';
import 'package:clima_ui/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:sizer/sizer.dart';

class FailureWidget extends HookWidget {
  const FailureWidget({required this.onRetry, required this.failure, Key? key})
      : super(key: key);
  final void Function() onRetry;
  final Failure failure;

  @override
  Widget build(BuildContext context) {
    final TextStyle mainTextStyle = TextStyle(
      color: Theme.of(context).textTheme.subtitle1!.color,
      fontWeight: FontWeight.bold,
      fontSize: MediaQuery.of(context).size.shortestSide < kTabletBreakpoint
          ? 25.sp
          : 15.sp,
    );
    final TextStyle secondaryTextStyle = TextStyle(
      color: Theme.of(context).textTheme.subtitle2!.color,
      fontSize: MediaQuery.of(context).size.shortestSide < kTabletBreakpoint
          ? 13.sp
          : 8.sp,
    );
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Hmm...',
          style: mainTextStyle,
        ),
        Text('something went', style: mainTextStyle),
        Padding(
          padding: EdgeInsets.only(bottom: 2.h),
          child: Text('wrong.', style: mainTextStyle),
        ),
        Text(
          'Looks like you lost your connection. Please',
          style: secondaryTextStyle,
        ),
        Text(
          'check it and try again',
          style: secondaryTextStyle,
        ),
        Padding(
          padding: EdgeInsets.only(top: 2.h),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              border: Border.all(
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
            child: TextButton(
              onPressed: onRetry,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
                child: Text(
                  'Try again',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                    fontSize: secondaryTextStyle.fontSize,
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
