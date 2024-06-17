import 'package:get/get.dart';
import 'package:triasmitra_mobile_app/features/authentication/screens/login/widgets/login.dart';
import 'package:triasmitra_mobile_app/navigation_menu.dart';
import 'package:triasmitra_mobile_app/utils/helpers/session_service.dart';
import 'package:triasmitra_mobile_app/utils/theme/theme.dart';
import 'package:flutter/material.dart';


class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {

  final SessionService _sessionService = SessionService();
  
  Future<Widget> _getInitialScreen() async {
    final session = await _sessionService.getSession();
    return session.isNotEmpty ?  NavigationMenu() : const LoginScreen();
  }
  
    return GetMaterialApp(
      themeMode: ThemeMode.system,
      theme: MainAppTheme.lightTheme,
      darkTheme: MainAppTheme.darkTheme,
      home: FutureBuilder<Widget>(
        future: _getInitialScreen(),
        builder: (BuildContext context, AsyncSnapshot<Widget> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          } else {
            return snapshot.data!;
          }
        },
      ),
    );
  }
}