import 'package:flutter/material.dart';

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
