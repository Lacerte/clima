import 'package:clima_domain/entities/unit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UnitDialog extends ConsumerWidget {
  static const _dialogOptions = {
    'Metric': UnitSystem.metric,
    'Imperial': UnitSystem.imperial,
  };

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final unit = watch(unitProvider);

    final radios = [
      for (final entry in _dialogOptions.entries)
        RadioListTile<UnitSystem>(
          title: Text(
            entry.key.toString(),
            style: TextStyle(
              color: Theme.of(context).textTheme.subtitle1!.color,
            ),
          ),
          value: entry.value,
          groupValue: unit.state,
          onChanged: (newValue) {
            unit.state = newValue!;
            Navigator.pop(context);
          },
        )
    ];

    return SimpleDialog(
      title: Text(
        'Unit',
        style: TextStyle(
          color: Theme.of(context).textTheme.subtitle1!.color,
        ),
      ),
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: radios,
        ),
      ],
    );
  }
}
