import 'package:flutter/material.dart';

bool isValidatedForm(GlobalKey<FormState> key) {
  if (key.currentState!.validate()) {
    return true;
  }
  return false;
}
