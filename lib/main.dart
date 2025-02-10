import 'package:flutter/material.dart';
import 'package:expense/widget/expenses.dart';
//import 'package:flutter/services.dart';

var kcolorscheme =
    ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 96, 58, 181));

var kdarkcolorscheme = ColorScheme.fromSeed(
    seedColor: const Color.fromARGB(255, 5, 99, 125),
    brightness: Brightness.dark);

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
  //     .then((fn) =>

  runApp(MaterialApp(
    darkTheme: ThemeData.dark().copyWith(
      useMaterial3: true,
      colorScheme: kdarkcolorscheme,
      cardTheme: CardTheme(
        color: kdarkcolorscheme.secondaryContainer,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: kdarkcolorscheme.primaryContainer,
          foregroundColor: kdarkcolorscheme.onPrimaryContainer,
        ),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: kdarkcolorscheme.primary,
        foregroundColor: kdarkcolorscheme.onPrimary,
      ),
    ),
    theme: ThemeData().copyWith(
      useMaterial3: true,
      colorScheme: kcolorscheme,
      appBarTheme: AppBarTheme(
        backgroundColor: kcolorscheme.primary,
        foregroundColor: kcolorscheme.onPrimary,
      ),
      cardTheme: CardTheme(
        color: kcolorscheme.secondaryContainer,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: kcolorscheme.primaryContainer,
          foregroundColor: kcolorscheme.onPrimaryContainer,
        ),
      ),
      textTheme: TextTheme(
        titleLarge: TextStyle(
          fontWeight: FontWeight.bold,
          color: kcolorscheme.onSecondaryContainer,
          fontSize: 14,
        ),
      ),
    ),
    themeMode: ThemeMode.system,
    home: const Expenses(),
    debugShowCheckedModeBanner: false,
  ));
}
