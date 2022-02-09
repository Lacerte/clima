/*
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

import 'package:clima_domain/entities/unit_system.dart';
import 'package:clima_ui/state_notifiers/unit_system_state_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UnitSystemDialog extends ConsumerWidget {
  static const _dialogOptions = {
    'Metric': UnitSystem.metric,
    'Imperial': UnitSystem.imperial,
  };

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final unitSystemState = ref.watch(unitSystemStateNotifierProvider);
    final unitSystemStateNotifier =
        ref.watch(unitSystemStateNotifierProvider.notifier);

    final radios = [
      for (final entry in _dialogOptions.entries)
        RadioListTile<UnitSystem>(
          title: Text(
            entry.key,
            style: TextStyle(
              color: Theme.of(context).textTheme.subtitle1!.color,
            ),
          ),
          value: entry.value,
          groupValue: unitSystemState.unitSystem,
          onChanged: (newValue) {
            unitSystemStateNotifier.setUnitSystem(newValue!);
            Navigator.pop(context);
          },
        )
    ];

    return SimpleDialog(
      title: Text(
        'Unit system',
        style: TextStyle(
          color: Theme.of(context).textTheme.subtitle1!.color,
        ),
      ),
      children: [Column(mainAxisSize: MainAxisSize.min, children: radios)],
    );
  }
}
