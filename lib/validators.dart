import 'package:flutter/material.dart';

class Validators {
  static FormFieldValidator required(
      {String errorText = "This field cannot be empty."}) {
    return (value) {
      if (value == null ||
          ((value is Iterable || value is String || value is Map) &&
              value.length == 0)) {
        return errorText;
      }
      return null;
    };
  }

  static FormFieldValidator validLength(int length,
      {String errorText = "Password cannot contain more than 3 characters"}) {
    return (value) {
      if (value != null && value.isNotEmpty) {
        if (value.length <= length) {
          return "Short password. Enter more than $length characters";
        }
      }
      return null;
    };
  }
}
