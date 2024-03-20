import 'package:flutter/material.dart';

extension StringExt on String {
  String get capitalize => '${this[0].toUpperCase()}${substring(1)}';
}

extension BuilderContext on BuildContext {
  // set theme
}
