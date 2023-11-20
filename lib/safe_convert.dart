library safe_convert;

import 'dart:convert';

import 'package:flutter/cupertino.dart';

/// A Calculator.
class SafeConvert {

  static T? asT<T extends Object?>(dynamic value, [T? defaultValue]) {
    if (value is T) {
      return value;
    }
    try {
      if (value != null) {
        final String valueS = value.toString();
        if ('' is T) {
          return valueS as T;
        } else if (0 is T) {
          return int.parse(valueS) as T;
        } else if (0.0 is T) {
          return double.parse(valueS) as T;
        } else if (false is T) {
          if (valueS == '0' || valueS == '1') {
            return (valueS == '1') as T;
          }
          return (valueS == 'true') as T;
        } else {
          return convert<T>(value);
        }
      }
    } catch (e, stackTrace) {
      debugPrint('asT<$T>' + e.toString());
      return defaultValue;
    }

    return defaultValue;
  }

  static T? Function<T extends Object?>(dynamic value) convert =
  <T>(dynamic value) {
    if (value == null) {
      return null;
    }
    return json.decode(value.toString()) as T?;
  };
}
