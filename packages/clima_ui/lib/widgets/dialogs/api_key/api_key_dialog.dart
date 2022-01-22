import 'package:clima_data/repos/api_key_repo.dart';
import 'package:clima_ui/widgets/others/link_text_span.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ApiKeyDialog extends ConsumerWidget {
  const ApiKeyDialog({required this.textFieldController, Key? key})
      : super(key: key);

  final TextEditingController textFieldController;
  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return AlertDialog(
      contentPadding: const EdgeInsets.all(16.0),
      content: TextFormField(
        controller: textFieldController,
        cursorColor: Theme.of(context).colorScheme.secondary,
        autofocus: true,
        decoration: InputDecoration(
          focusColor: Theme.of(context).colorScheme.secondary,
          hintText: 'Enter API Key',
          hintStyle: TextStyle(
            color: Theme.of(context).textTheme.subtitle2!.color,
          ),
        ),
        onEditingComplete: () {},
      ),
      actions: <Widget>[
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
            'SAVE',
            style: TextStyle(
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
        )
      ],
    );
  }
}
