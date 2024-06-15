import 'package:flutter/material.dart';
import 'package:triasmitra_mobile_app/utils/theme/custom_themes/appbar_theme.dart';
import 'package:triasmitra_mobile_app/utils/theme/custom_themes/bottom_sheet_theme.dart';
import 'package:triasmitra_mobile_app/utils/theme/custom_themes/checkbox_theme.dart';
import 'package:triasmitra_mobile_app/utils/theme/custom_themes/chip_theme.dart';
import 'package:triasmitra_mobile_app/utils/theme/custom_themes/elevated_button_theme.dart';
import 'package:triasmitra_mobile_app/utils/theme/custom_themes/outlined_button_theme.dart';
import 'package:triasmitra_mobile_app/utils/theme/custom_themes/text_field_theme.dart';
import 'package:triasmitra_mobile_app/utils/theme/custom_themes/text_theme.dart';

class MainAppTheme{
    MainAppTheme._();
    
    static ThemeData lightTheme = ThemeData(
      useMaterial3: true,
      fontFamily: 'Poppins',
      brightness: Brightness.light,
      primaryColor: Colors.blue,
      scaffoldBackgroundColor: Colors.white,
      textTheme: MainTextTheme.lightTextTheme,
      chipTheme: MainChipTheme.lightChipTheme,
      appBarTheme: MainAppBarTheme.lightAppBarTheme,
      checkboxTheme: MainCheckboxTheme.lightCheckboxTheme,
      bottomSheetTheme: MainBottomSheetTheme.lightBottomSheetTheme,
      elevatedButtonTheme: MainElevatedButtonTheme.lightElevatedButtonTheme,
      outlinedButtonTheme: MainOutlinedButtonTheme.lightOutlineButtonTheme,
      inputDecorationTheme: MainTextFormFieldTheme.lightInputDecorationTheme
    ); 

    static ThemeData darkTheme = ThemeData(
      useMaterial3: true,
      fontFamily: 'Poppins',
      brightness: Brightness.dark,
      primaryColor: Colors.blue,
      scaffoldBackgroundColor: Colors.black,
      textTheme: MainTextTheme.darkTextTheme,
      chipTheme: MainChipTheme.darkChipTheme,
      appBarTheme: MainAppBarTheme.darkAppBarTheme,
      checkboxTheme: MainCheckboxTheme.darkCheckboxTheme,
      bottomSheetTheme: MainBottomSheetTheme.darkBottomSheetTheme,
      elevatedButtonTheme: MainElevatedButtonTheme.darkElevatedButtonTheme,
      outlinedButtonTheme: MainOutlinedButtonTheme.darkOutlineButtonTheme,
      inputDecorationTheme: MainTextFormFieldTheme.darkInputDecorationTheme
    ); 
}