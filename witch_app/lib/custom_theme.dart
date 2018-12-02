/**
 * Creating custom color palettes is part of creating a custom app. The idea is to create
 * your class of custom colors, in this case `CompanyColors` and then create a `ThemeData`
 * object with those colors you just defined.
 *
 * Resource:
 * A good resource would be this website: http://mcg.mbitson.com/
 * You simply need to put in the colour you wish to use, and it will generate all shades
 * for you. Your primary colour will be the `500` value.
 *
 * Colour Creation:
 * In order to create the custom colours you need to create a `Map<int, Color>` object
 * which will have all the shade values. `const Color(0xFF...)` will be how you create
 * the colours. The six character hex code is what follows. If you wanted the colour
 * #114488 or #D39090 as primary colours in your theme, then you would have
 * `const Color(0x114488)` and `const Color(0xD39090)`, respectively.
 *
 * Usage:
 * In order to use this newly created theme or even the colours in it, you would just
 * `import` this file in your project, anywhere you needed it.
 * `import 'path/to/theme.dart';`
 */

import 'package:flutter/material.dart';

final ThemeData CustomTheme = new ThemeData(
    brightness: Brightness.light,
    primarySwatch: CustomColors.greenBlue,
    primaryColor: CustomColors.greenBlue[500],
    primaryColorBrightness: Brightness.light,
    accentColor: CustomColors.darkPink[500],
    accentColorBrightness: Brightness.light,
    fontFamily: 'RobotoMono',
    primaryTextTheme: TextTheme(
        title: TextStyle(
            color: Colors.white
        )
    ),
    primaryIconTheme:  IconThemeData(
      color: Colors.white, //change your color here
    ),
);

class CustomColors {
  CustomColors._();
  static const MaterialColor greenBlue = MaterialColor(
    _greenBluePrimaryValue,
    <int, Color>{
      50: const Color(0xFFEAF9F6),
      100: const Color(0xFFCAF0E7),
      200: const Color(0xFFA7E7D8),
      300: const Color(0xFF83DDC8),
      400: const Color(0xFF69D5BC),
      500: Color(_greenBluePrimaryValue),
      600: const Color(0xFF47C9A9),
      700: const Color(0xFF3DC2A0),
      800: const Color(0xFF35BC97),
      900: const Color(0xFF25B087)
    },
  );
  static const int _greenBluePrimaryValue = 0xFF4ECEB0;

  static const Map<int, Color> darkPink = const <int, Color> {
    50: const Color(0xFFFAEBEF),
    100: const Color(0xFFF2CDD7),
    200: const Color(0xFFE9ACBD),
    300: const Color(0xFFE08AA3),
    400: const Color(0xFFDA718F),
    500: const Color(_darkPinkPrimaryValue),
    600: const Color(0xFFCE5073),
    700: const Color(0xFFC84768),
    800: const Color(0xFFC23D5E),
    900: const Color(0xFFB72D4B)
  };
  static const int _darkPinkPrimaryValue = 0xFFD3587B;

  static const Map<int, Color> lightPink = const <int, Color> {
    50: const Color(0xFFFAEBEF),
    100: const Color(0xFFF2CDD7),
    200: const Color(0xFFE9ACBD),
    300: const Color(0xFFE08AA3),
    400: const Color(0xFFDA718F),
    500: const Color(_lightPinkPrimaryValue),
    600: const Color(0xFFCE5073),
    700: const Color(0xFFC84768),
    800: const Color(0xFFC23D5E),
    900: const Color(0xFFB72D4B)
  };
  static const int _lightPinkPrimaryValue = 0xFFF7CBD7;

  static const Map<int, Color> lightYellow = const <int, Color> {
    50: const Color(0xFFFFFDF0),
    100: const Color(0xFFFFFBD9),
    200: const Color(0xFFFFF9C0),
    300: const Color(0xFFFFF6A7),
    400: const Color(0xFFFFF494),
    500: const Color(_lightYellowPrimaryValue),
    600: const Color(0xFFFFF079),
    700: const Color(0xFFFFEE6E),
    800: const Color(0xFFFFEC64),
    900: const Color(0xFFFFE851)
  };
  static const int _lightYellowPrimaryValue = 0xFFFFF281;
}