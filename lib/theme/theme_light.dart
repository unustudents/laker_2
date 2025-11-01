import 'package:flutter/material.dart';
import 'package:laker_2/gen/fonts.gen.dart';

import '../core/constant/constants.dart';

class ThemeApp {
  ThemeApp._();

  static ThemeData light = ThemeData(
    useMaterial3: true,
    // appBarTheme: TAppBar.lightAppBarTheme,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.biruTua,
      foregroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      titleTextStyle: const TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 20.0,
      ),
    ),
    fontFamily: FontFamily.poppins,
    brightness: Brightness.light,
    // elevatedButtonTheme: TElevatedButton.lightElevatedButtonTheme,
    primaryColor: AppColors.biruTua,
    secondaryHeaderColor: AppColors.warning,
    scaffoldBackgroundColor: Colors.white,
    // textTheme: TTextTheme.lightTextTheme,
    // bottomSheetTheme: TBottomSheet.lightBottomSheetTheme,
    // checkboxTheme: TCheckboxTheme.lightCheckboxTheme,
    // chipTheme: TChipTheme.lightChipTheme,
    // outlinedButtonTheme: TOutlineButton.lightOutlinedButtonTheme,
    cardTheme: const CardThemeData(
      color: Colors.white,
      elevation: 5,
      surfaceTintColor: Colors.transparent,
    ),
    dialogTheme: const DialogThemeData(surfaceTintColor: Colors.white),
    dividerTheme: DividerThemeData(
      color: AppColors.biruTua,
      thickness: 1.0,
      space: 8.0,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(15.0),
        backgroundColor: AppColors.biruTua,
        foregroundColor: Colors.white,
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        textStyle: const TextStyle(fontSize: 18),
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColors.biruTua,
      foregroundColor: Colors.white,
    ),
    inputDecorationTheme: const InputDecorationTheme(
      alignLabelWithHint: true,
      border: OutlineInputBorder(),
      counterStyle: TextStyle(color: Colors.pink),
      isDense: true,
    ),
    listTileTheme: ListTileThemeData(
      shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(30)),
      style: ListTileStyle.drawer,
      selectedTileColor: AppColors.biruTua,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 15.0,
        vertical: 8.0,
      ),
    ),
  );
}
