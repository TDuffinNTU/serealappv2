import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// The custom theme for Sereal App.
class SerealTheme {
  ThemeData get lightTheme => FlexThemeData.light(
        colorScheme: colorScheme,
        scheme: FlexScheme.brandBlue,
        surfaceMode: FlexSurfaceMode.highScaffoldLowSurface,
        blendLevel: 15,
        appBarStyle: FlexAppBarStyle.primary,
        subThemesData: const FlexSubThemesData(
          blendOnLevel: 10,
          blendOnColors: false,
          useMaterial3Typography: true,
          useM2StyleDividerInM3: true,
          navigationBarSelectedLabelSchemeColor: SchemeColor.onPrimary,
          navigationBarUnselectedLabelSchemeColor: SchemeColor.inversePrimary,
          navigationBarSelectedIconSchemeColor: SchemeColor.primary,
          navigationBarUnselectedIconSchemeColor: SchemeColor.inversePrimary,
          navigationBarIndicatorSchemeColor: SchemeColor.onPrimary,
          navigationBarBackgroundSchemeColor: SchemeColor.primary,
          menuIndicatorBackgroundSchemeColor: SchemeColor.primary,
        ),
        keyColors: const FlexKeyColors(),
        visualDensity: FlexColorScheme.comfortablePlatformDensity,
        useMaterial3: true,
        swapLegacyOnMaterial3: true,
        fontFamily: GoogleFonts.notoSans().fontFamily,
      );

  ThemeData get darkTheme => FlexThemeData.dark(
        colorScheme: colorScheme,
        surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
        appBarStyle: FlexAppBarStyle.background,
        blendLevel: 13,
        subThemesData:  FlexSubThemesData(
          blendOnLevel: 20,
          useMaterial3Typography: true,
          useM2StyleDividerInM3: true,
          navigationBarSelectedLabelSchemeColor: SchemeColor.onSurface,
          navigationBarUnselectedLabelSchemeColor: SchemeColor.onSurface,
          navigationBarSelectedIconSchemeColor: SchemeColor.surface,
          navigationBarUnselectedIconSchemeColor: SchemeColor.onSurface,
          navigationBarIndicatorSchemeColor: SchemeColor.onSurface,
          navigationBarBackgroundSchemeColor: SchemeColor.surface,
          navigationBarElevation: 0,
        ),
        keyColors: const FlexKeyColors(keepPrimary: true),
        visualDensity: FlexColorScheme.comfortablePlatformDensity,
        useMaterial3: true,
        swapLegacyOnMaterial3: true,
        fontFamily: GoogleFonts.notoSans().fontFamily,
      );

  /// TODO use a provider to manage this bad boy
  ColorScheme get colorScheme => SeedColorScheme.fromSeeds(primaryKey: Color(0xFF5D6CBD));
}
