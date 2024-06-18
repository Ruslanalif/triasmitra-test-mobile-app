
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:triasmitra_mobile_app/features/authentication/screens/login/widgets/login.dart';
import 'package:triasmitra_mobile_app/navigation_menu.dart';
import 'package:triasmitra_mobile_app/utils/helpers/helper_functions.dart';
import 'package:triasmitra_mobile_app/utils/helpers/session_service.dart';
import 'package:triasmitra_mobile_app/utils/http/http_client.dart';

class LoginController extends GetxController{

  static LoginController get instance => Get.find();

  final hidePassword = true.obs;
  final username = TextEditingController();
  final password = TextEditingController();
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  final SessionService _sessionService = SessionService();

  Future<void> login() async{
    try{
      
      if(!loginFormKey.currentState!.validate()) return;

      // LoginModel(id: "1", firstName: firstName.text.trim(), lastName: lastName.text.trim(), username: username.text.trim(), password: password.text.trim(), email: email.text.trim(), phone: phone.text.trim());
      final Map<String, String> data = {
        'UserName': username.text.trim(),
        'Password': password.text.trim(),
      };
      // final Map<String, String> data = LoginModel(id: 1, firstName: firstName.text.trim(), lastName: lastName.text.trim(), username: username.text.trim(), password: password.text.trim(), email: email.text.trim(), phone: phone.text.trim());

      final String token = 'Kosong';

      // Gunakan fungsi helper untuk mengirim data
      final response = await MainHttpClient.post('login', data, token);

      // print("data" + data.toString());
      if(response['xStatus'] == "0"){
        MainHelperFunction.showAlert("Error", response['xMessage']);
      }else if(response['xStatus'] == "1"){
        String res_token = response['access_token'];
        print('Bearer $res_token');
        print(response['data']['ID']);
        print(username.text.trim());
        print(response['data']['Name']);
        print(response['data']['Phone']);
        print(response['data']['Email']);
        //  await _sessionService.setSession(
        //   token: 'Bearer $res_token',
        //   id: response['data']['ID'],
        //   username: username.text.trim(),
        //   name: response['data']['Name'],
        //   phone: response['data']['Phone'],
        //   email: response['data']['Email'],
        // );
        try {
          await _sessionService.setSession(
            token: 'Bearer $res_token',
            id: response['data']['ID'].toString(),
            username: username.text.trim(),
            name: response['data']['Name'],
            phone: response['data']['Phone'],
            email: response['data']['Email'],
          );
          print("setSession completed without errors");
        } catch (e) {
          print("Error setting session: $e");
        }
        Get.to(() => NavigationMenu());   
      }else{
        MainHelperFunction.showAlert("Info", response.toString());
      }
    
      // print(response['xStatus']);
      // print(username.text.trim());
    }catch(e){
      Exception(e);
    }finally{
      
    }
  }

  Future<void> logout(String prmToken) async {
    final Map<String, String> data = {
        'no_need_data': ''
      };
      // final Map<String, String> data = LoginModel(id: 1, firstName: firstName.text.trim(), lastName: lastName.text.trim(), username: username.text.trim(), password: password.text.trim(), email: email.text.trim(), phone: phone.text.trim());

      final String token = prmToken;

      // Gunakan fungsi helper untuk mengirim data
      final response = await MainHttpClient.post('logout', data, token);

      // print("data" + data.toString());
      if(response['xStatus'] == "0"){
        MainHelperFunction.showAlert("Errro", "Some Errer Response ");
      }else if(response['xStatus'] == "1"){
        await _sessionService.clearSession();
        Get.to(() => const LoginScreen());   
      }
      // final session = await _sessionService.getSession();
      // print(session);
      // Get.to(() => const LoginScreen());   

  }
}