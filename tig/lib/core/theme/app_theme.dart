import 'package:flutter/material.dart';

ThemeData buildLightTheme() {
  return ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.black,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
        color: Colors.white,
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: Colors.black,
          fontFamily: 'PaperlogyExtraBold',
          fontSize: 20,
        ),
        iconTheme: IconThemeData(
          color: Colors.black,
          weight: 2.0,
        ),
        actionsIconTheme: IconThemeData(
          color: Colors.black,
          weight: 2.0,
        )),
    textTheme: const TextTheme(
      headlineMedium:
          TextStyle(color: Colors.black, fontFamily: 'PaperlogySemiBold'),
      bodyLarge: TextStyle(color: Colors.black, fontFamily: 'PaperlogyRegular'),
      bodyMedium:
          TextStyle(color: Colors.black, fontFamily: 'PaperlogyRegular'),
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
          const TextStyle(
            fontSize: 14,
            fontFamily: 'PaperlogySemiBold',
          ),
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(Colors.black),
        foregroundColor: WidgetStateProperty.all(Colors.white),
        textStyle: WidgetStateProperty.all(
          const TextStyle(
            fontSize: 10,
            fontFamily: 'PaperlogySemiBold',
          ),
        ),
      ),
    ),
    datePickerTheme: DatePickerThemeData(
      backgroundColor: Colors.white,
      headerBackgroundColor: Colors.black,
      headerForegroundColor: Colors.white,
      yearStyle: const TextStyle(
        color: Colors.white,
        fontFamily: 'PaperlogyExtraBold',
        fontSize: 20,
      ),
      dayStyle: const TextStyle(
        color: Colors.black,
        fontFamily: 'PaperlogyRegular',
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
    dialogTheme: const DialogTheme(
      backgroundColor: Colors.white,
      alignment: Alignment.center,
      titleTextStyle: TextStyle(
        fontFamily: 'PaperlogyExtraBold',
        fontSize: 16,
        color: Colors.black,
      ),
      contentTextStyle: TextStyle(
        fontFamily: 'PaperlogyRegular',
        fontSize: 14,
        color: Colors.black,
      ),
    ),
  );
}

ThemeData buildDarkTheme() {
  return ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.white,
    scaffoldBackgroundColor: Colors.black,
    appBarTheme: const AppBarTheme(
      color: Colors.black,
      centerTitle: true,
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontFamily: 'PaperlogyExtraBold',
        fontSize: 20,
      ),
      iconTheme: IconThemeData(
        color: Colors.white,
        weight: 2.0,
      ),
      actionsIconTheme: IconThemeData(
        color: Colors.white,
        weight: 2.0,
      ),
    ),
    textTheme: const TextTheme(
      headlineMedium:
          TextStyle(color: Colors.white, fontFamily: 'PaperlogySemiBold'),
      bodyLarge: TextStyle(color: Colors.white, fontFamily: 'PaperlogyRegular'),
      bodyMedium:
          TextStyle(color: Colors.white, fontFamily: 'PaperlogyRegular'),
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
          const TextStyle(
            fontSize: 14,
            fontFamily: 'PaperlogySemiBold',
          ),
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(Colors.white),
        foregroundColor: WidgetStateProperty.all(Colors.black),
        textStyle: WidgetStateProperty.all(
          const TextStyle(
            fontSize: 10,
            fontFamily: 'PaperlogySemiBold',
          ),
        ),
      ),
    ),
    datePickerTheme: DatePickerThemeData(
      backgroundColor: Colors.black,
      headerBackgroundColor: Colors.red,
      headerForegroundColor: Colors.white,
      yearStyle: const TextStyle(
        color: Colors.white,
        fontFamily: 'PaperlogyExtraBold',
        fontSize: 20,
      ),
      dayStyle: const TextStyle(
        color: Colors.white,
        fontFamily: 'PaperlogyRegular',
      ),
      todayBackgroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return Colors.white;
        }
        return Colors.grey.shade800;
      }),
      todayForegroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return Colors.white;
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
    dialogTheme: const DialogTheme(
      shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.white),
          borderRadius: BorderRadius.all(Radius.circular(8))),
      backgroundColor: Colors.black,
      alignment: Alignment.center,
      titleTextStyle: TextStyle(
        fontFamily: 'PaperlogyExtraBold',
        fontSize: 16,
        color: Colors.white,
      ),
      contentTextStyle: TextStyle(
        fontFamily: 'PaperlogyRegular',
        fontSize: 14,
        color: Colors.white,
      ),
    ),
  );
}
