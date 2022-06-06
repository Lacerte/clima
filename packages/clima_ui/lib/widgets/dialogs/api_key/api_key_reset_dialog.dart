import 'package:flutter/material.dart';

class ApiKeyResetDialog extends StatelessWidget {
  const ApiKeyResetDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => AlertDialog(
        title: Text(
          'Reset API Key?',
          style: TextStyle(
            color: Theme.of(context).textTheme.subtitle1!.color,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              'CANCEL',
              style: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              'RESET',
              style: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
          ),
        ],
      );
}
