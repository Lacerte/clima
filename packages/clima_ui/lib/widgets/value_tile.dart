import 'package:flutter/material.dart';

import 'empty_widget.dart';

/// General utility widget used to render a cell divided into three rows
/// First row displays [label]
/// second row displays [iconData]
/// third row displays [value]
class ValueTile extends StatelessWidget {
  const ValueTile(this.label, this.value, {Key key, this.iconData}) : super(key: key);

  final String label;
  final String value;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          label,
          style: TextStyle(color: Theme.of(context).accentColor.withAlpha(80)),
        ),
        const SizedBox(
          height: 5,
        ),
        if (iconData != null)
            Icon(
                iconData,
                color: Theme.of(context).accentColor,
                size: 20,
            ),
        const SizedBox(
          height: 10,
        ),
        Text(
          value,
          style: TextStyle(color: Theme.of(context).accentColor),
        ),
      ],
    );
  }
}
