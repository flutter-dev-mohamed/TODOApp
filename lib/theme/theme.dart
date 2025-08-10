import "package:flutter/material.dart";

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff00687a),
      surfaceTint: Color(0xff00687a),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xffacedff),
      onPrimaryContainer: Color(0xff004e5c),
      secondary: Color(0xff4b6269),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xffcee7ef),
      onSecondaryContainer: Color(0xff334a51),
      tertiary: Color(0xff565d7e),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xffdde1ff),
      onTertiaryContainer: Color(0xff3f4565),
      error: Color(0xffba1a1a),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdad6),
      onErrorContainer: Color(0xff93000a),
      surface: Color(0xfff5fafc),
      onSurface: Color(0xff171c1e),
      onSurfaceVariant: Color(0xff3f484b),
      outline: Color(0xff70797b),
      outlineVariant: Color(0xffbfc8cb),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2c3133),
      inversePrimary: Color(0xff84d2e7),
      primaryFixed: Color(0xffacedff),
      onPrimaryFixed: Color(0xff001f26),
      primaryFixedDim: Color(0xff84d2e7),
      onPrimaryFixedVariant: Color(0xff004e5c),
      secondaryFixed: Color(0xffcee7ef),
      onSecondaryFixed: Color(0xff061f24),
      secondaryFixedDim: Color(0xffb2cbd2),
      onSecondaryFixedVariant: Color(0xff334a51),
      tertiaryFixed: Color(0xffdde1ff),
      onTertiaryFixed: Color(0xff131937),
      tertiaryFixedDim: Color(0xffbfc4eb),
      onTertiaryFixedVariant: Color(0xff3f4565),
      surfaceDim: Color(0xffd5dbdd),
      surfaceBright: Color(0xfff5fafc),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xffeff4f7),
      surfaceContainer: Color(0xffe9eff1),
      surfaceContainerHigh: Color(0xffe4e9eb),
      surfaceContainerHighest: Color(0xffdee3e5),
    );
  }

  ThemeData light() {
    return theme(lightScheme());
  }

  static ColorScheme lightMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff003c47),
      surfaceTint: Color(0xff00687a),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff1e778a),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff233a40),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff597178),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff2e3453),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff656b8d),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff740006),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffcf2c27),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfff5fafc),
      onSurface: Color(0xff0c1214),
      onSurfaceVariant: Color(0xff2f383a),
      outline: Color(0xff4b5457),
      outlineVariant: Color(0xff666f71),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2c3133),
      inversePrimary: Color(0xff84d2e7),
      primaryFixed: Color(0xff1e778a),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff005d6e),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff597178),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff41585f),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff656b8d),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff4d5374),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffc2c7c9),
      surfaceBright: Color(0xfff5fafc),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xffeff4f7),
      surfaceContainer: Color(0xffe4e9eb),
      surfaceContainerHigh: Color(0xffd8dee0),
      surfaceContainerHighest: Color(0xffcdd2d5),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme());
  }

  static ColorScheme lightHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff00313b),
      surfaceTint: Color(0xff00687a),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff00515f),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff182f35),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff364d53),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff242a48),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff414767),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff600004),
      onError: Color(0xffffffff),
      errorContainer: Color(0xff98000a),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfff5fafc),
      onSurface: Color(0xff000000),
      onSurfaceVariant: Color(0xff000000),
      outline: Color(0xff252e30),
      outlineVariant: Color(0xff424b4d),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2c3133),
      inversePrimary: Color(0xff84d2e7),
      primaryFixed: Color(0xff00515f),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff003843),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff364d53),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff1f363c),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff414767),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff2b314f),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffb4babc),
      surfaceBright: Color(0xfff5fafc),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xffecf2f4),
      surfaceContainer: Color(0xffdee3e5),
      surfaceContainerHigh: Color(0xffd0d5d7),
      surfaceContainerHighest: Color(0xffc2c7c9),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme());
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xff84d2e7),
      surfaceTint: Color(0xff84d2e7),
      onPrimary: Color(0xff003640),
      primaryContainer: Color(0xff004e5c),
      onPrimaryContainer: Color(0xffacedff),
      secondary: Color(0xffb2cbd2),
      onSecondary: Color(0xff1d343a),
      secondaryContainer: Color(0xff334a51),
      onSecondaryContainer: Color(0xffcee7ef),
      tertiary: Color(0xffbfc4eb),
      onTertiary: Color(0xff282f4d),
      tertiaryContainer: Color(0xff3f4565),
      onTertiaryContainer: Color(0xffdde1ff),
      error: Color(0xffffb4ab),
      onError: Color(0xff690005),
      errorContainer: Color(0xff93000a),
      onErrorContainer: Color(0xffffdad6),
      surface: Color(0xff0f1416),
      onSurface: Color(0xffdee3e5),
      onSurfaceVariant: Color(0xffbfc8cb),
      outline: Color(0xff899295),
      outlineVariant: Color(0xff3f484b),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffdee3e5),
      inversePrimary: Color(0xff00687a),
      primaryFixed: Color(0xffacedff),
      onPrimaryFixed: Color(0xff001f26),
      primaryFixedDim: Color(0xff84d2e7),
      onPrimaryFixedVariant: Color(0xff004e5c),
      secondaryFixed: Color(0xffcee7ef),
      onSecondaryFixed: Color(0xff061f24),
      secondaryFixedDim: Color(0xffb2cbd2),
      onSecondaryFixedVariant: Color(0xff334a51),
      tertiaryFixed: Color(0xffdde1ff),
      onTertiaryFixed: Color(0xff131937),
      tertiaryFixedDim: Color(0xffbfc4eb),
      onTertiaryFixedVariant: Color(0xff3f4565),
      surfaceDim: Color(0xff0f1416),
      surfaceBright: Color(0xff343a3c),
      surfaceContainerLowest: Color(0xff090f11),
      surfaceContainerLow: Color(0xff171c1e),
      surfaceContainer: Color(0xff1b2022),
      surfaceContainerHigh: Color(0xff252b2d),
      surfaceContainerHighest: Color(0xff303638),
    );
  }

  ThemeData dark() {
    return theme(darkScheme());
  }

  static ColorScheme darkMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xff9ae8fd),
      surfaceTint: Color(0xff84d2e7),
      onPrimary: Color(0xff002a33),
      primaryContainer: Color(0xff4c9baf),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xffc8e1e8),
      onSecondary: Color(0xff11292f),
      secondaryContainer: Color(0xff7d959c),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xffd5daff),
      onTertiary: Color(0xff1d2442),
      tertiaryContainer: Color(0xff898fb3),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xffffd2cc),
      onError: Color(0xff540003),
      errorContainer: Color(0xffff5449),
      onErrorContainer: Color(0xff000000),
      surface: Color(0xff0f1416),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xffd5dee1),
      outline: Color(0xffaab3b6),
      outlineVariant: Color(0xff899295),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffdee3e5),
      inversePrimary: Color(0xff004f5e),
      primaryFixed: Color(0xffacedff),
      onPrimaryFixed: Color(0xff001419),
      primaryFixedDim: Color(0xff84d2e7),
      onPrimaryFixedVariant: Color(0xff003c47),
      secondaryFixed: Color(0xffcee7ef),
      onSecondaryFixed: Color(0xff001419),
      secondaryFixedDim: Color(0xffb2cbd2),
      onSecondaryFixedVariant: Color(0xff233a40),
      tertiaryFixed: Color(0xffdde1ff),
      onTertiaryFixed: Color(0xff080f2c),
      tertiaryFixedDim: Color(0xffbfc4eb),
      onTertiaryFixedVariant: Color(0xff2e3453),
      surfaceDim: Color(0xff0f1416),
      surfaceBright: Color(0xff404547),
      surfaceContainerLowest: Color(0xff04080a),
      surfaceContainerLow: Color(0xff191e20),
      surfaceContainer: Color(0xff23292b),
      surfaceContainerHigh: Color(0xff2e3335),
      surfaceContainerHighest: Color(0xff393f40),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme());
  }

  static ColorScheme darkHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffd6f5ff),
      surfaceTint: Color(0xff84d2e7),
      onPrimary: Color(0xff000000),
      primaryContainer: Color(0xff80cee3),
      onPrimaryContainer: Color(0xff000d12),
      secondary: Color(0xffdbf4fc),
      onSecondary: Color(0xff000000),
      secondaryContainer: Color(0xffaec7ce),
      onSecondaryContainer: Color(0xff000d12),
      tertiary: Color(0xffefefff),
      onTertiary: Color(0xff000000),
      tertiaryContainer: Color(0xffbbc1e7),
      onTertiaryContainer: Color(0xff030826),
      error: Color(0xffffece9),
      onError: Color(0xff000000),
      errorContainer: Color(0xffffaea4),
      onErrorContainer: Color(0xff220001),
      surface: Color(0xff0f1416),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xffffffff),
      outline: Color(0xffe9f1f5),
      outlineVariant: Color(0xffbbc4c7),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffdee3e5),
      inversePrimary: Color(0xff004f5e),
      primaryFixed: Color(0xffacedff),
      onPrimaryFixed: Color(0xff000000),
      primaryFixedDim: Color(0xff84d2e7),
      onPrimaryFixedVariant: Color(0xff001419),
      secondaryFixed: Color(0xffcee7ef),
      onSecondaryFixed: Color(0xff000000),
      secondaryFixedDim: Color(0xffb2cbd2),
      onSecondaryFixedVariant: Color(0xff001419),
      tertiaryFixed: Color(0xffdde1ff),
      onTertiaryFixed: Color(0xff000000),
      tertiaryFixedDim: Color(0xffbfc4eb),
      onTertiaryFixedVariant: Color(0xff080f2c),
      surfaceDim: Color(0xff0f1416),
      surfaceBright: Color(0xff4b5153),
      surfaceContainerLowest: Color(0xff000000),
      surfaceContainerLow: Color(0xff1b2022),
      surfaceContainer: Color(0xff2c3133),
      surfaceContainerHigh: Color(0xff373c3e),
      surfaceContainerHighest: Color(0xff42484a),
    );
  }

  ThemeData darkHighContrast() {
    return theme(darkHighContrastScheme());
  }

  ThemeData theme(ColorScheme colorScheme) => ThemeData(
        useMaterial3: true,
        brightness: colorScheme.brightness,
        colorScheme: colorScheme,
        textTheme: textTheme.apply(
          bodyColor: colorScheme.onSurface,
          displayColor: colorScheme.onSurface,
        ),
        scaffoldBackgroundColor: colorScheme.background,
        canvasColor: colorScheme.surface,
      );

  List<ExtendedColor> get extendedColors => [];
}

class ExtendedColor {
  final Color seed, value;
  final ColorFamily light;
  final ColorFamily lightHighContrast;
  final ColorFamily lightMediumContrast;
  final ColorFamily dark;
  final ColorFamily darkHighContrast;
  final ColorFamily darkMediumContrast;

  const ExtendedColor({
    required this.seed,
    required this.value,
    required this.light,
    required this.lightHighContrast,
    required this.lightMediumContrast,
    required this.dark,
    required this.darkHighContrast,
    required this.darkMediumContrast,
  });
}

class ColorFamily {
  const ColorFamily({
    required this.color,
    required this.onColor,
    required this.colorContainer,
    required this.onColorContainer,
  });

  final Color color;
  final Color onColor;
  final Color colorContainer;
  final Color onColorContainer;
}
