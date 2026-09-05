import 'package:flutter/material.dart';

extension BuildContextExtensions on BuildContext {
  bool get isDark => Theme.of(this).brightness == Brightness.dark;

  ThemeData get theme => Theme.of(this);

  TextTheme get textTheme => Theme.of(this).textTheme;

  double get height => MediaQuery.of(this).size.height;

  double get width => MediaQuery.of(this).size.width;
}

extension ThemeExtension on ThemeData {
  Color get secondaryColor => colorScheme.secondary;
}
