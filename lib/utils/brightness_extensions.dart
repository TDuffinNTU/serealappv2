import 'dart:ui';

extension BrightnessExtensions on Brightness {
  bool get isDark => this == Brightness.dark;
  Brightness get toggled => isDark ? Brightness.light : Brightness.dark;
}
