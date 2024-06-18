import 'package:flutter/material.dart';
import 'package:triasmitra_mobile_app/utils/constants/colors.dart';

class MainChipTheme{
  MainChipTheme._();

  static ChipThemeData lightChipTheme = ChipThemeData(
    // disabledColor: Colors.grey.withOpacity(0.4),
    disabledColor: MainColors.accentColor.withOpacity(0.4),
    labelStyle: const TextStyle(color: Colors.black),
    selectedColor: MainColors.accentColor,
    // selectedColor: Colors.blue,
    padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
    checkmarkColor: Colors.white
  );

  static ChipThemeData darkChipTheme = ChipThemeData(
    // disabledColor: Colors.grey,
    disabledColor:  MainColors.accentColor,
    labelStyle: const TextStyle(color: Colors.white),
    // selectedColor: Colors.blue,
    selectedColor: MainColors.accentColor,
    padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
    checkmarkColor: Colors.white,
  );

}