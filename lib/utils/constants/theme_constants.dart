import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Color defaultSeedColor = Color(0xFF5D6CBD);

ThemeData lightTheme(Color seedColor) => FlexThemeData.light(
      colorScheme: SeedColorScheme.fromSeeds(primaryKey: seedColor),
      surfaceMode: FlexSurfaceMode.highScaffoldLowSurface,
      blendLevel: 15,
      appBarStyle: FlexAppBarStyle.primary,
      subThemesData: const FlexSubThemesData(
        blendOnLevel: 10,
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
      swapLegacyOnMaterial3: true,
      fontFamily: GoogleFonts.notoSans().fontFamily,
    );

ThemeData darkTheme(Color seedColor) => FlexThemeData.dark(
      colorScheme: SeedColorScheme.fromSeeds(primaryKey: seedColor),
      surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
      appBarStyle: FlexAppBarStyle.background,
      blendLevel: 13,
      subThemesData: const FlexSubThemesData(
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
      swapLegacyOnMaterial3: true,
      fontFamily: GoogleFonts.notoSans().fontFamily,
    );
