import 'package:flutter/material.dart';

class MainColors{
  MainColors._();

  static const Color bglightColor = Color(0xFFE4E2DF); 
  static const Color primaryColor = Color(0xFF356b74); 
  static const Color accentColor = Color(0xFFA87958); 

  static const Gradient buttonGradientPrimary = LinearGradient(
    begin: Alignment(0.0, 0.0),
    end: Alignment(0.707, -0.707),
    colors: [
    Color.fromARGB(255, 207, 122, 61),
    Color(0xFFA87958),
    Color.fromARGB(255, 188, 148, 119)
    ]
  );
}