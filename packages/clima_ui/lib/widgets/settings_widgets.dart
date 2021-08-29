import 'package:clima_ui/themes/clima_theme.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsTile extends StatelessWidget {
  const SettingsTile(
      {required this.title,
      this.padding,
      this.subtitle,
      this.leading,
      this.isThreeLine,
      this.onTap});

  final String title;
  final String? subtitle;
  final Widget? leading;
  final VoidCallback? onTap;
  final double? padding;
  final bool? isThreeLine;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      isThreeLine: isThreeLine ?? false,
      contentPadding: EdgeInsets.symmetric(horizontal: padding ?? 24.0),
      leading: leading,
      title: Text(
        title,
        style: TextStyle(
          color: Theme.of(context).textTheme.subtitle1!.color,
        ),
      ),
      subtitle: subtitle != null
          ? Text(
              subtitle!,
              style: TextStyle(
                color: Theme.of(context).textTheme.subtitle2!.color,
              ),
            )
          : null,
      onTap: onTap,
    );
  }
}

class SettingsHeader extends StatelessWidget {
  const SettingsHeader({required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 24),
      child: Container(
        height: 30.0,
        padding: const EdgeInsets.symmetric(horizontal: 80),
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                color: Theme.of(context).accentColor,
              ),
        ),
      ),
    );
  }
}

class SettingsDivider extends StatelessWidget {
  const SettingsDivider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 1,
      color: Theme.of(context).textTheme.subtitle1!.color!.withAlpha(65),
    );
  }
}

InlineSpan linkTextSpan({
  required String text,
  required String url,
  required BuildContext context,
}) {
  return TextSpan(
    text: text,
    style: TextStyle(
      color: Theme.of(context).accentColor,
    ),
    recognizer: TapGestureRecognizer()..onTap = () => launch(url),
  );
}

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
