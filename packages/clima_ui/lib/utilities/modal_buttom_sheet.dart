import 'package:clima_ui/themes/clima_theme.dart';
import 'package:flutter/material.dart';

Future<void> showGeneralSheet(BuildContext context,
    {required Widget child, required String title}) {
  return showModalBottomSheet(
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
    builder: (context) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 4.0,
            width: 25.0,
            margin: const EdgeInsets.only(top: 8.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2.0),
              color: ClimaTheme.of(context).sheetPillColor,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 8.0,
              horizontal: 48.0,
            ),
            child: Text(
              title,
              style: Theme.of(context).textTheme.subtitle1,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.clip,
            ),
          ),
          const Divider(height: 1),
          Flexible(
            child: SingleChildScrollView(child: child),
          ),
        ],
      );
    },
  );
}
