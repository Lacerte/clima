import 'package:flutter/material.dart';

class SettingsTile extends StatelessWidget {
  const SettingsTile(
      {this.title,
      this.subtitle,
      this.icon,
      this.onTap,
      this.padding,
      this.isThreeLine});

  final String title;
  final String subtitle;
  final Icon icon;
  final VoidCallback onTap;
  final double padding;
  final bool isThreeLine;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      isThreeLine: isThreeLine ?? false,
      contentPadding: EdgeInsets.symmetric(horizontal: padding ?? 24.0),
      leading: icon,
      title: Text(
        title,
        style: TextStyle(
          color: Theme.of(context).textTheme.subtitle1.color,
        ),
      ),
      subtitle: subtitle != null
          ? Text(
              subtitle,
              style: TextStyle(
                color: Theme.of(context).textTheme.subtitle2.color,
              ),
            )
          : null,
      onTap: onTap,
    );
  }
}

class SettingsHeader extends StatelessWidget {
  const SettingsHeader({this.title});
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
          style: Theme.of(context).textTheme.bodyText1.copyWith(
                color: Theme.of(context).accentColor,
              ),
        ),
      ),
    );
  }
}

class SettingsDivider extends StatelessWidget {
  const SettingsDivider({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 1,
      color: Theme.of(context).textTheme.subtitle1.color.withAlpha(65),
    );
  }
}
