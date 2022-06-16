import 'package:dot_messenger/config/constant.dart';
import 'package:flutter/material.dart';

class CustomThemeData {
  static ThemeData themeLight(BuildContext context) {
    final ThemeData base = ThemeData.light();

    return base.copyWith(
      scaffoldBackgroundColor: kBackgroundColors,
      appBarTheme: base.appBarTheme.copyWith(
        color: kBackgroundColors,
        elevation: 0,
        iconTheme: base.iconTheme.copyWith(
          color: Colors.black,
        ),
        titleTextStyle: base.textTheme.headline3!.copyWith(
          color: Colors.black,
          fontSize: 20.0,
          fontWeight: FontWeight.w600,
        ),
        centerTitle: false,
      ),
      textTheme: base.textTheme.copyWith(
        headline3: base.textTheme.headline3!.copyWith(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
        headline4: base.textTheme.headline4!.copyWith(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
        subtitle1: base.textTheme.subtitle1!.copyWith(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Colors.grey,
        ),
        bodyText2: base.textTheme.bodyText2!.copyWith(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Colors.grey[600],
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 28,
          vertical: 22,
        ),
        filled: true,
        fillColor: Colors.white,
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.transparent,
          ),
          borderRadius: BorderRadius.circular(
            30.0,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.transparent,
          ),
          borderRadius: BorderRadius.circular(
            30.0,
          ),
        ),
        border: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.transparent,
          ),
          borderRadius: BorderRadius.circular(
            30.0,
          ),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              30.0,
            ),
          ),
          fixedSize: const Size(
            double.infinity,
            55.0,
          ),
        ),
      ),
      useMaterial3: true,
    );
  }
}
