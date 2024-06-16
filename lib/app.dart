import 'package:get/get.dart';
import 'package:triasmitra_mobile_app/features/authentication/screens/login/widgets/login.dart';
import 'package:triasmitra_mobile_app/utils/theme/theme.dart';
import 'package:flutter/material.dart';


class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      themeMode: ThemeMode.system,
      theme: MainAppTheme.lightTheme,
      darkTheme: MainAppTheme.darkTheme,
      home: const LoginScreen(),
    );
  }
}