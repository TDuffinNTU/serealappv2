import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Color kDefaultSeedColor = Color(0xFF5D6CBD);

/// The custom theme for Sereal App.
ThemeData lightTheme(Color? seedColor) => FlexThemeData.light(
      colorScheme: SeedColorScheme.fromSeeds(primaryKey: seedColor ?? kDefaultSeedColor),
      // scheme: FlexScheme.brandBlue, // Not sure why this is here tbh?
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

ThemeData darkTheme(Color? seedColor) => FlexThemeData.dark(
      colorScheme: SeedColorScheme.fromSeeds(primaryKey: seedColor ?? kDefaultSeedColor),
      surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
      appBarStyle: FlexAppBarStyle.background,
      blendLevel: 13,
      subThemesData: FlexSubThemesData(
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
