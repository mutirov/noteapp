import 'package:flutter/material.dart';
import 'package:notes_app/tools/constants.dart';

final baseTheme = ThemeData(
  useMaterial3: true,
  fontFamily: 'Poppins',
  scaffoldBackgroundColor: background,
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
);

final customTheme = baseTheme.copyWith(
  appBarTheme: baseTheme.appBarTheme.copyWith(
    backgroundColor: Colors.transparent,
    titleTextStyle: TextStyle(
      color: primary,
      fontSize: 32,
      fontFamily: 'Fredoka',
      fontWeight: FontWeight.w600,
    ),
  ),
);
