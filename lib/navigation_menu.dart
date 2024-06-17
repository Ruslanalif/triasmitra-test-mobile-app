
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:iconsax/iconsax.dart';
import 'package:triasmitra_mobile_app/features/masters/home.dart';
import 'package:triasmitra_mobile_app/features/masters/profile.dart';
import 'package:triasmitra_mobile_app/utils/helpers/helper_functions.dart';
import 'package:triasmitra_mobile_app/utils/helpers/session_service.dart';

class NavigationMenu extends StatefulWidget {
  @override
  _NavigationMenuState createState() => _NavigationMenuState();
}

class NavigationController extends GetxController{
  final Rx<int> selectedIndex = 0.obs;

  final screen =  [
          const MainHome(),
          Container(color: Colors.grey,),
          MainProfile(),
        ];
}


class _NavigationMenuState extends State<NavigationMenu> {
  final SessionService _sessionService = SessionService();
  String _sessionData = 'No session data';

  @override
  void initState() {
    super.initState();
    _loadSession();
  }

  Future<void> _loadSession() async {
    final session = await _sessionService.getSession();
    setState(() {
      _sessionData = session.isNotEmpty ? session.toString() : 'No session data';
    });
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());
    final dark = MainHelperFunction.isDarkMode(context);
    return Scaffold(
      bottomNavigationBar: Obx(
        () => NavigationBar(
          height: 80,
          elevation: 0,
          selectedIndex: controller.selectedIndex.value,
          onDestinationSelected: (index) =>  controller.selectedIndex.value = index,
          backgroundColor: dark ? Colors.black : Colors.white,
          indicatorColor: dark ? Colors.white.withOpacity(0.1) : Colors.black.withOpacity(0.1),
          destinations: [
            NavigationDestination(icon: Icon(Iconsax.home), label: "Home",),
            NavigationDestination(icon: Icon(Iconsax.star_slash), label: "Non Active",),
            NavigationDestination(icon: Icon(Iconsax.user), label: "Profile",),
          ],
        ),
      ),
      body: Obx(() => controller.screen[controller.selectedIndex.value]),
    );
  }
}