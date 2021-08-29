/* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/. */

import 'package:riverpod/riverpod.dart';

enum UnitSystem { metric, imperial }

final unitProvider = StateProvider((ref) => UnitSystem.metric);
