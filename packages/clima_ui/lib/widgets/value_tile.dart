import 'package:flutter/material.dart';

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
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Text(
            label,
            style: TextStyle(
              color: Theme.of(context).textTheme.subtitle1.color.withAlpha(120),
            ),
          ),
        ),
        Text(
          value,
          style: TextStyle(
            color: Theme.of(context).textTheme.subtitle1.color,
          ),
        ),
      ],
    );
  }
}
