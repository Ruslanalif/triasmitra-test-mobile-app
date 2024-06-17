import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:triasmitra_mobile_app/common/styles/spacing_styles.dart';
import 'package:triasmitra_mobile_app/features/authentication/controllers/login_controller.dart';
import 'package:triasmitra_mobile_app/utils/constants/image_strings.dart';
import 'package:triasmitra_mobile_app/utils/constants/sizes.dart';
import 'package:triasmitra_mobile_app/utils/helpers/session_service.dart';

class MainProfile extends StatefulWidget {
  @override
  _MainProfileState createState() => _MainProfileState();
  
}
                  

class _MainProfileState extends State<MainProfile> {
  final SessionService _sessionService = SessionService();
  String _sessionData = 'No session data';
  String _token = 'Loading...';
  String _id = 'Loading...';
  String _username = 'Loading...';
  String _name = 'Loading...';
  String _email = 'Loading...';
  String _phone = 'Loading...';

  @override
  void initState() {
    super.initState();
    _loadSession();
  }

  Future<void> _loadSession() async {
    final session = await _sessionService.getSession();
    setState(() {
      _sessionData = session.isNotEmpty ? session.toString() : 'No session data';
      _token = session['token'] ?? 'No token found';
      _id = session['id'] ?? 'No token found';
      _username = session['username'] ?? 'No token found';
      _name = session['name'] ?? 'No token found';
      _email = session['email'] ?? 'No token found';
      _phone = session['phone'] ?? 'No token found';
    });
  }


  @override
  Widget build(BuildContext context) {
      final SessionService _sessionService = SessionService();

      Future<Map> _getInitialScreen() async {
        return await _sessionService.getSession();
      }


    final controller = Get.put(LoginController());
    return Scaffold(
      body: SingleChildScrollView(
        padding: MainSpacingStyle.paddingWithAppBarHeight,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
              padding:  EdgeInsets.only(top: 50),
              child: CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage(MainImages.userImage),
              ),
            ),
            const SizedBox(height: MainSize.spaceBtwItems*0.9),
            Text(_name, style: Theme.of(context).textTheme.headlineMedium ),
            const SizedBox(height: MainSize.spaceBtwItems*0.5),
            Text(
              'Username: $_username',
              style: Theme.of(context).textTheme.bodyLarge
            ),
            const SizedBox(height: MainSize.spaceBtwItems*0.5),
            Text(
              'Phone: $_phone',
              style: Theme.of(context).textTheme.bodyMedium
            ),            
            const SizedBox(height: MainSize.spaceBtwItems*0.5),
            Text(
              'Email: $_email',
              style: Theme.of(context).textTheme.bodyMedium
            ),
            const SizedBox(height: MainSize.spaceBtwItems*1.7),
            SizedBox(width: double.infinity, child: ElevatedButton(onPressed: () => controller.logout(_token), child: Text("Logout")),),

          ],
          // children: [
          //   // Text('token $_token'),
          //   // Text('id $_id'),
          //   Text('username $_username'),
          //   Text('name $_name'),
          //   Text('email $_email'),
          //   Text('phone $_phone'),
          //   SizedBox(width: double.infinity, child: ElevatedButton(onPressed: () => controller.logout(_token), child: Text("Logout")),),
          // ],
        ),
      ),
    );
  }
}