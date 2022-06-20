/*
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/.
 */

import 'package:equatable/equatable.dart';

const _defaultApiKey = '0cca00b6155fcac417cc140a5deba9a4';

class ApiKeyModel extends Equatable {
  // There's an underscore here because `default` can't be an identifier in
  // Dart.
  const ApiKeyModel.default_()
      : apiKey = _defaultApiKey,
        isCustom = false;

  const ApiKeyModel.custom(this.apiKey) : isCustom = true;

  factory ApiKeyModel.parse(String? string) {
    if (string == null) return const ApiKeyModel.default_();

    return ApiKeyModel.custom(string);
  }

  final String apiKey;

  final bool isCustom;

  @override
  List<Object?> get props => [apiKey, isCustom];
}
