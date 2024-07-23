import "package:flutter/material.dart";

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(4278845507),
      surfaceTint: Color(4284109739),
      onPrimary: Color(4294967295),
      primaryContainer: Color(4280885112),
      onPrimaryContainer: Color(4290426111),
      secondary: Color(4281794779),
      onSecondary: Color(4294967295),
      secondaryContainer: Color(4284368895),
      onSecondaryContainer: Color(4294967295),
      tertiary: Color(4278217317),
      onTertiary: Color(4294967295),
      tertiaryContainer: Color(4285530102),
      onTertiaryContainer: Color(4278212178),
      error: Color(4290386458),
      onError: Color(4294967295),
      errorContainer: Color(4294957782),
      onErrorContainer: Color(4282449922),
      surface: Color(4294768895),
      onSurface: Color(4280032033),
      onSurfaceVariant: Color(4282860881),
      outline: Color(4286084482),
      outlineVariant: Color(4291347667),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4281413686),
      inversePrimary: Color(4291150079),
      primaryFixed: Color(4293189631),
      onPrimaryFixed: Color(4279501158),
      primaryFixedDim: Color(4291150079),
      onPrimaryFixedVariant: Color(4282530449),
      secondaryFixed: Color(4293189631),
      onSecondaryFixed: Color(4279566439),
      secondaryFixedDim: Color(4291150079),
      onSecondaryFixedVariant: Color(4281925856),
      tertiaryFixed: Color(4278254834),
      onTertiaryFixed: Color(4278198302),
      tertiaryFixedDim: Color(4278246869),
      onTertiaryFixedVariant: Color(4278210636),
      surfaceDim: Color(4292663521),
      surfaceBright: Color(4294768895),
      surfaceContainerLowest: Color(4294967295),
      surfaceContainerLow: Color(4294374138),
      surfaceContainer: Color(4293979381),
      surfaceContainerHigh: Color(4293650415),
      surfaceContainerHighest: Color(4293255657),
    );
  }

  ThemeData light() {
    return theme(lightScheme());
  }

  static ColorScheme lightMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(4278845507),
      surfaceTint: Color(4284109739),
      onPrimary: Color(4294967295),
      primaryContainer: Color(4280885112),
      onPrimaryContainer: Color(4293650431),
      secondary: Color(4281663701),
      onSecondary: Color(4294967295),
      secondaryContainer: Color(4284368895),
      onSecondaryContainer: Color(4294967295),
      tertiary: Color(4278209352),
      onTertiary: Color(4294967295),
      tertiaryContainer: Color(4278223741),
      onTertiaryContainer: Color(4294967295),
      error: Color(4287365129),
      onError: Color(4294967295),
      errorContainer: Color(4292490286),
      onErrorContainer: Color(4294967295),
      surface: Color(4294768895),
      onSurface: Color(4280032033),
      onSurfaceVariant: Color(4282597709),
      outline: Color(4284505706),
      outlineVariant: Color(4286347654),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4281413686),
      inversePrimary: Color(4291150079),
      primaryFixed: Color(4285557187),
      onPrimaryFixed: Color(4294967295),
      primaryFixedDim: Color(4283912360),
      onPrimaryFixedVariant: Color(4294967295),
      secondaryFixed: Color(4285225727),
      onSecondaryFixed: Color(4294967295),
      secondaryFixedDim: Color(4283313407),
      onSecondaryFixedVariant: Color(4294967295),
      tertiaryFixed: Color(4278223741),
      onTertiaryFixed: Color(4294967295),
      tertiaryFixedDim: Color(4278216547),
      onTertiaryFixedVariant: Color(4294967295),
      surfaceDim: Color(4292663521),
      surfaceBright: Color(4294768895),
      surfaceContainerLowest: Color(4294967295),
      surfaceContainerLow: Color(4294374138),
      surfaceContainer: Color(4293979381),
      surfaceContainerHigh: Color(4293650415),
      surfaceContainerHighest: Color(4293255657),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme());
  }

  static ColorScheme lightHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(4278845507),
      surfaceTint: Color(4284109739),
      onPrimary: Color(4294967295),
      primaryContainer: Color(4280885112),
      onPrimaryContainer: Color(4294967295),
      secondary: Color(4279894137),
      onSecondary: Color(4294967295),
      secondaryContainer: Color(4281663701),
      onSecondaryContainer: Color(4294967295),
      tertiary: Color(4278200101),
      onTertiary: Color(4294967295),
      tertiaryContainer: Color(4278209352),
      onTertiaryContainer: Color(4294967295),
      error: Color(4283301890),
      onError: Color(4294967295),
      errorContainer: Color(4287365129),
      onErrorContainer: Color(4294967295),
      surface: Color(4294768895),
      onSurface: Color(4278190080),
      onSurfaceVariant: Color(4280558381),
      outline: Color(4282597709),
      outlineVariant: Color(4282597709),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4281413686),
      inversePrimary: Color(4293847551),
      primaryFixed: Color(4282267277),
      onPrimaryFixed: Color(4294967295),
      primaryFixedDim: Color(4280753270),
      onPrimaryFixedVariant: Color(4294967295),
      secondaryFixed: Color(4281663701),
      onSecondaryFixed: Color(4294967295),
      secondaryFixedDim: Color(4280483991),
      onSecondaryFixedVariant: Color(4294967295),
      tertiaryFixed: Color(4278209352),
      onTertiaryFixed: Color(4294967295),
      tertiaryFixedDim: Color(4278203185),
      onTertiaryFixedVariant: Color(4294967295),
      surfaceDim: Color(4292663521),
      surfaceBright: Color(4294768895),
      surfaceContainerLowest: Color(4294967295),
      surfaceContainerLow: Color(4294374138),
      surfaceContainer: Color(4293979381),
      surfaceContainerHigh: Color(4293650415),
      surfaceContainerHighest: Color(4293255657),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme());
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(4291150079),
      surfaceTint: Color(4291150079),
      onPrimary: Color(4281016697),
      primaryContainer: Color(4279435363),
      onPrimaryContainer: Color(4288846840),
      secondary: Color(4291150079),
      onSecondary: Color(4280680609),
      secondaryContainer: Color(4282585591),
      onSecondaryContainer: Color(4294308351),
      tertiary: Color(4294967295),
      onTertiary: Color(4278204212),
      tertiaryContainer: Color(4278250979),
      onTertiaryContainer: Color(4278208580),
      error: Color(4294948011),
      onError: Color(4285071365),
      errorContainer: Color(4287823882),
      onErrorContainer: Color(4294957782),
      surface: Color(4279440152),
      onSurface: Color(4293255657),
      onSurfaceVariant: Color(4291347667),
      outline: Color(4287795101),
      outlineVariant: Color(4282860881),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4293255657),
      inversePrimary: Color(4284109739),
      primaryFixed: Color(4293189631),
      onPrimaryFixed: Color(4279501158),
      primaryFixedDim: Color(4291150079),
      onPrimaryFixedVariant: Color(4282530449),
      secondaryFixed: Color(4293189631),
      onSecondaryFixed: Color(4279566439),
      secondaryFixedDim: Color(4291150079),
      onSecondaryFixedVariant: Color(4281925856),
      tertiaryFixed: Color(4278254834),
      onTertiaryFixed: Color(4278198302),
      tertiaryFixedDim: Color(4278246869),
      onTertiaryFixedVariant: Color(4278210636),
      surfaceDim: Color(4279440152),
      surfaceBright: Color(4282005567),
      surfaceContainerLowest: Color(4279111187),
      surfaceContainerLow: Color(4280032033),
      surfaceContainer: Color(4280295205),
      surfaceContainerHigh: Color(4280953135),
      surfaceContainerHighest: Color(4281676858),
    );
  }

  ThemeData dark() {
    return theme(darkScheme());
  }

  static ColorScheme darkMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(4291478783),
      surfaceTint: Color(4291150079),
      onPrimary: Color(4279238744),
      primaryContainer: Color(4287465185),
      onPrimaryContainer: Color(4278190080),
      secondary: Color(4291478783),
      onSecondary: Color(4279238744),
      secondaryContainer: Color(4287332607),
      onSecondaryContainer: Color(4278190080),
      tertiary: Color(4294967295),
      onTertiary: Color(4278204212),
      tertiaryContainer: Color(4278250979),
      onTertiaryContainer: Color(4278199330),
      error: Color(4294949553),
      onError: Color(4281794561),
      errorContainer: Color(4294923337),
      onErrorContainer: Color(4278190080),
      surface: Color(4279440152),
      onSurface: Color(4294900223),
      onSurfaceVariant: Color(4291611095),
      outline: Color(4288979375),
      outlineVariant: Color(4286873999),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4293255657),
      inversePrimary: Color(4282596242),
      primaryFixed: Color(4293189631),
      onPrimaryFixed: Color(4278976586),
      primaryFixedDim: Color(4291150079),
      onPrimaryFixedVariant: Color(4281411711),
      secondaryFixed: Color(4293189631),
      onSecondaryFixed: Color(4278976585),
      secondaryFixedDim: Color(4291150079),
      onSecondaryFixedVariant: Color(4281008305),
      tertiaryFixed: Color(4278254834),
      onTertiaryFixed: Color(4278195219),
      tertiaryFixedDim: Color(4278246869),
      onTertiaryFixedVariant: Color(4278205755),
      surfaceDim: Color(4279440152),
      surfaceBright: Color(4282005567),
      surfaceContainerLowest: Color(4279111187),
      surfaceContainerLow: Color(4280032033),
      surfaceContainer: Color(4280295205),
      surfaceContainerHigh: Color(4280953135),
      surfaceContainerHighest: Color(4281676858),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme());
  }

  static ColorScheme darkHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(4294900223),
      surfaceTint: Color(4291150079),
      onPrimary: Color(4278190080),
      primaryContainer: Color(4291478783),
      onPrimaryContainer: Color(4278190080),
      secondary: Color(4294900223),
      onSecondary: Color(4278190080),
      secondaryContainer: Color(4291478783),
      onSecondaryContainer: Color(4278190080),
      tertiary: Color(4294967295),
      onTertiary: Color(4278190080),
      tertiaryContainer: Color(4278250979),
      onTertiaryContainer: Color(4278190080),
      error: Color(4294965753),
      onError: Color(4278190080),
      errorContainer: Color(4294949553),
      onErrorContainer: Color(4278190080),
      surface: Color(4279440152),
      onSurface: Color(4294967295),
      onSurfaceVariant: Color(4294900223),
      outline: Color(4291611095),
      outlineVariant: Color(4291611095),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4293255657),
      inversePrimary: Color(4280555891),
      primaryFixed: Color(4293453055),
      onPrimaryFixed: Color(4278190080),
      primaryFixedDim: Color(4291478783),
      onPrimaryFixedVariant: Color(4279238744),
      secondaryFixed: Color(4293453055),
      onSecondaryFixed: Color(4278190080),
      secondaryFixedDim: Color(4291478783),
      onSecondaryFixedVariant: Color(4279238744),
      tertiaryFixed: Color(4283170806),
      onTertiaryFixed: Color(4278190080),
      tertiaryFixedDim: Color(4278248153),
      onTertiaryFixedVariant: Color(4278196761),
      surfaceDim: Color(4279440152),
      surfaceBright: Color(4282005567),
      surfaceContainerLowest: Color(4279111187),
      surfaceContainerLow: Color(4280032033),
      surfaceContainer: Color(4280295205),
      surfaceContainerHigh: Color(4280953135),
      surfaceContainerHighest: Color(4281676858),
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
          bodyColor: colorScheme.onInverseSurface,
          displayColor: colorScheme.onInverseSurface,
        ),
        scaffoldBackgroundColor: colorScheme.surface,
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
