import 'package:flutter/material.dart';

enum FontLocale { de, en, es, ja, ko, pt, zh_CN, zh_TW }

extension on FontLocale {
  String get extraBoldFontName {
    switch (this) {
      case FontLocale.zh_CN:
      case FontLocale.zh_TW:
        return "MaoKenShiJinHei";
      default:
        return "PaperlogyExtraBold";
    }
  }

  String get semiBoldFontName {
    switch (this) {
      case FontLocale.zh_CN:
      case FontLocale.zh_TW:
        return "MaoKenShiJinHei";
      default:
        return "PaperlogySemiBold";
    }
  }

  String get regularFontName {
    switch (this) {
      case FontLocale.zh_CN:
      case FontLocale.zh_TW:
        return "CangJiGaoDeGuoMiaoHei";
      default:
        return "PaperlogyRegular";
    }
  }
}

ThemeData buildLightTheme(FontLocale locale) {
  final String extraBoldFontName = locale.extraBoldFontName;
  final String semiBoldFontName = locale.semiBoldFontName;
  final String regularFontName = locale.regularFontName;

  return ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.black,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
        color: Colors.white,
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: Colors.black,
          fontFamily: extraBoldFontName,
          fontSize: 20,
        ),
        iconTheme: const IconThemeData(
          color: Colors.black,
          weight: 2.0,
        ),
        actionsIconTheme: const IconThemeData(
          color: Colors.black,
          weight: 2.0,
        )),
    textTheme: TextTheme(
      headlineMedium:
          TextStyle(color: Colors.black, fontFamily: semiBoldFontName),
      bodyLarge: TextStyle(color: Colors.black, fontFamily: regularFontName),
      bodyMedium: TextStyle(color: Colors.black, fontFamily: regularFontName),
    ),
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {
        TargetPlatform.android: CupertinoPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      },
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(Colors.black),
        foregroundColor: WidgetStateProperty.all(Colors.white),
        iconColor: WidgetStateProperty.all(Colors.white),
        textStyle: WidgetStateProperty.all(
          TextStyle(
            fontSize: 14,
            fontFamily: semiBoldFontName,
          ),
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(Colors.black),
        foregroundColor: WidgetStateProperty.all(Colors.white),
        textStyle: WidgetStateProperty.all(
          TextStyle(
            fontSize: 10,
            fontFamily: semiBoldFontName,
          ),
        ),
      ),
    ),
    datePickerTheme: DatePickerThemeData(
      backgroundColor: Colors.white,
      headerBackgroundColor: Colors.black,
      headerForegroundColor: Colors.white,
      yearStyle: TextStyle(
        color: Colors.white,
        fontFamily: extraBoldFontName,
        fontSize: 20,
      ),
      dayStyle: TextStyle(
        color: Colors.black,
        fontFamily: regularFontName,
      ),
      todayBackgroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return Colors.black;
        }
        return Colors.grey.shade200;
      }),
      todayForegroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return Colors.white;
        }
        return Colors.black;
      }),
      dayBackgroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return Colors.black;
        }
        return Colors.white;
      }),
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: Colors.white,
    ),
    switchTheme: SwitchThemeData(
      trackColor: WidgetStateProperty.resolveWith<Color?>(
        (states) {
          if (states.contains(WidgetState.selected)) {
            return Colors.black;
          }
          return Colors.grey;
        },
      ),
      thumbColor: WidgetStateProperty.resolveWith<Color?>(
        (states) {
          if (states.contains(WidgetState.selected)) {
            return Colors.white;
          }
          return Colors.grey.shade300;
        },
      ),
    ),
    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStateProperty.resolveWith<Color?>(
        (states) {
          if (states.contains(WidgetState.selected)) {
            return Colors.black;
          }
          return Colors.white;
        },
      ),
      checkColor: WidgetStateProperty.all(Colors.white),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
      side: const BorderSide(color: Colors.black, width: 2),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      border: UnderlineInputBorder(),
      focusedBorder: UnderlineInputBorder(borderSide: BorderSide(width: 2.0)),
      hintStyle: TextStyle(
        color: Colors.grey,
      ),
      labelStyle: TextStyle(
        color: Colors.black,
      ),
      errorStyle: TextStyle(
        color: Colors.red,
      ),
    ),
    dialogTheme: DialogTheme(
      backgroundColor: Colors.white,
      alignment: Alignment.center,
      titleTextStyle: TextStyle(
        fontFamily: semiBoldFontName,
        fontSize: 16,
        color: Colors.black,
      ),
      contentTextStyle: TextStyle(
        fontFamily: regularFontName,
        fontSize: 14,
        color: Colors.black,
      ),
    ),
    progressIndicatorTheme:
        const ProgressIndicatorThemeData(color: Colors.black),
    segmentedButtonTheme: SegmentedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return Colors.black;
          }
          return Colors.grey.shade100;
        }),
        foregroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return Colors.white;
          }
          return Colors.grey.shade400;
        }),
        textStyle: WidgetStateProperty.all(
          TextStyle(
            fontFamily: semiBoldFontName,
            fontSize: 12,
          ),
        ),
        side: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const BorderSide(color: Colors.black, width: 2);
          }
          return const BorderSide(color: Colors.grey, width: 1);
        }),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    ),
  );
}

ThemeData buildDarkTheme(FontLocale locale) {
  final String extraBoldFontName = locale.extraBoldFontName;
  final String semiBoldFontName = locale.semiBoldFontName;
  final String regularFontName = locale.regularFontName;
  return ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.white,
    scaffoldBackgroundColor: Colors.black,
    appBarTheme: AppBarTheme(
      color: Colors.black,
      centerTitle: true,
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontFamily: extraBoldFontName,
        fontSize: 20,
      ),
      iconTheme: const IconThemeData(
        color: Colors.white,
        weight: 2.0,
      ),
      actionsIconTheme: const IconThemeData(
        color: Colors.white,
        weight: 2.0,
      ),
    ),
    textTheme: TextTheme(
      headlineMedium:
          TextStyle(color: Colors.white, fontFamily: semiBoldFontName),
      bodyLarge: TextStyle(color: Colors.white, fontFamily: regularFontName),
      bodyMedium: TextStyle(color: Colors.white, fontFamily: regularFontName),
    ),
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {
        TargetPlatform.android: CupertinoPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      },
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(Colors.white),
        foregroundColor: WidgetStateProperty.all(Colors.black),
        iconColor: WidgetStateProperty.all(Colors.black),
        textStyle: WidgetStateProperty.all(
          TextStyle(
            fontSize: 14,
            fontFamily: semiBoldFontName,
          ),
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(Colors.white),
        foregroundColor: WidgetStateProperty.all(Colors.black),
        textStyle: WidgetStateProperty.all(
          TextStyle(
            fontSize: 10,
            fontFamily: semiBoldFontName,
          ),
        ),
      ),
    ),
    datePickerTheme: DatePickerThemeData(
      backgroundColor: Colors.black,
      headerBackgroundColor: Colors.white,
      headerForegroundColor: Colors.black,
      yearStyle: TextStyle(
        color: Colors.white,
        fontFamily: extraBoldFontName,
        fontSize: 20,
      ),
      dayStyle: TextStyle(
        color: Colors.white,
        fontFamily: regularFontName,
      ),
      todayBackgroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return Colors.white;
        }
        return Colors.grey.shade800;
      }),
      todayForegroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return Colors.black;
        }
        return Colors.white;
      }),
      dayBackgroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return Colors.white;
        }
        return Colors.black;
      }),
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: Colors.black,
    ),
    switchTheme: SwitchThemeData(
      trackColor: WidgetStateProperty.resolveWith<Color?>(
        (states) {
          if (states.contains(WidgetState.selected)) {
            return Colors.white;
          }
          return Colors.grey;
        },
      ),
      thumbColor: WidgetStateProperty.resolveWith<Color?>(
        (states) {
          if (states.contains(WidgetState.selected)) {
            return Colors.black;
          }
          return Colors.grey.shade700;
        },
      ),
    ),
    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStateProperty.resolveWith<Color?>(
        (states) {
          if (states.contains(WidgetState.selected)) {
            return Colors.white;
          }
          return Colors.black;
        },
      ),
      checkColor: WidgetStateProperty.all(Colors.black),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
      side: const BorderSide(color: Colors.white, width: 2),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      filled: true,
      fillColor: Colors.black,
      border: UnderlineInputBorder(),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(width: 2.0, color: Colors.white),
      ),
      hintStyle: TextStyle(
        color: Colors.grey,
      ),
      labelStyle: TextStyle(
        color: Colors.white,
      ),
      errorStyle: TextStyle(
        color: Colors.red,
      ),
    ),
    dialogTheme: DialogTheme(
      shape: const RoundedRectangleBorder(
          side: BorderSide(color: Colors.white),
          borderRadius: BorderRadius.all(Radius.circular(8))),
      backgroundColor: Colors.black,
      alignment: Alignment.center,
      titleTextStyle: TextStyle(
        fontFamily: extraBoldFontName,
        fontSize: 16,
        color: Colors.white,
      ),
      contentTextStyle: TextStyle(
        fontFamily: regularFontName,
        fontSize: 14,
        color: Colors.white,
      ),
    ),
    progressIndicatorTheme:
        const ProgressIndicatorThemeData(color: Colors.white),
    segmentedButtonTheme: SegmentedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return Colors.white;
          }
          return Colors.grey.shade900;
        }),
        foregroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return Colors.black;
          }
          return Colors.grey.shade700;
        }),
        textStyle: WidgetStateProperty.all(
          TextStyle(
            fontFamily: semiBoldFontName,
            fontSize: 12,
          ),
        ),
        side: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const BorderSide(color: Colors.white, width: 2);
          }
          return const BorderSide(color: Colors.grey, width: 1);
        }),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    ),
  );
}
