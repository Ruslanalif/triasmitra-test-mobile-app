
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:triasmitra_mobile_app/features/authentication/screens/register/widgets/register_success.dart';
import 'package:triasmitra_mobile_app/navigation_menu.dart';
import 'package:triasmitra_mobile_app/utils/helpers/helper_functions.dart';
import 'package:triasmitra_mobile_app/utils/http/http_client.dart';

class LoginController extends GetxController{

  static LoginController get instance => Get.find();

  final hidePassword = true.obs;
  final username = TextEditingController();
  final password = TextEditingController();
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  Future<void> login() async{
    try{
      
      if(!loginFormKey.currentState!.validate()) return;

      // LoginModel(id: "1", firstName: firstName.text.trim(), lastName: lastName.text.trim(), username: username.text.trim(), password: password.text.trim(), email: email.text.trim(), phone: phone.text.trim());
      final Map<String, String> data = {
        'UserName': username.text.trim(),
        'Password': password.text.trim(),
      };
      // final Map<String, String> data = LoginModel(id: 1, firstName: firstName.text.trim(), lastName: lastName.text.trim(), username: username.text.trim(), password: password.text.trim(), email: email.text.trim(), phone: phone.text.trim());

      // Ganti dengan token Anda
      final String token = 'Kosong';

      // Gunakan fungsi helper untuk mengirim data
      final response = await MainHttpClient.post('login', data, token);

      // print("data" + data.toString());
      if(response['xStatus'] == "0"){
        MainHelperFunction.showAlert("Error", response['xMessage']);
      }else if(response['xStatus'] == "1"){
        Get.to(() => const NavigationMenu());   
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

}