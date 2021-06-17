import 'package:auto_size_text/auto_size_text.dart';
import 'package:clima_ui/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

/// General utility widget used to render a cell divided into three rows
/// First row displays [label]
/// second row displays [iconData]
/// third row displays [value]
class ValueTile extends StatelessWidget {
  const ValueTile(this.label, this.value, {Key key}) : super(key: key);

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: AutoSizeText(
              label,
              maxLines: 1,
              style: TextStyle(
                fontSize:
                    constraints.maxWidth < kTabletBreakpoint ? 11.sp : 8.sp,
                color:
                    Theme.of(context).textTheme.subtitle1.color.withAlpha(130),
              ),
            ),
          ),
          AutoSizeText(
            value,
            style: TextStyle(
              fontSize: constraints.maxWidth < kTabletBreakpoint ? 11.sp : 8.sp,
              color: Theme.of(context).textTheme.subtitle1.color,
            ),
          ),
        ],
      ),
    );
  }
}
