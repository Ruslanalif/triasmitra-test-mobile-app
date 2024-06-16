
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:triasmitra_mobile_app/features/authentication/models/login_model.dart';
import 'package:triasmitra_mobile_app/features/authentication/screens/register/widgets/register_success.dart';
import 'package:triasmitra_mobile_app/utils/helpers/helper_functions.dart';
import 'package:triasmitra_mobile_app/utils/http/http_client.dart';

class RegisterController extends GetxController{

  static RegisterController get instance => Get.find();

  final hidePassword = true.obs;
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final username = TextEditingController();
  final password = TextEditingController();
  final email = TextEditingController();
  final phone = TextEditingController();
  GlobalKey<FormState> registerFormKey = GlobalKey<FormState>();

  Future<void> register() async{
    try{
      
      if(!registerFormKey.currentState!.validate()) return;

      // LoginModel(id: "1", firstName: firstName.text.trim(), lastName: lastName.text.trim(), username: username.text.trim(), password: password.text.trim(), email: email.text.trim(), phone: phone.text.trim());
      final Map<String, String> data = {
        'UserName': username.text.trim(),
        'Password': password.text.trim(),
        'Name': firstName.text.trim() + " " + lastName.text.trim(),
        'Phone': phone.text.trim(),
        'Email': email.text.trim(),
        'UserID': "",
      };
      // final Map<String, String> data = LoginModel(id: 1, firstName: firstName.text.trim(), lastName: lastName.text.trim(), username: username.text.trim(), password: password.text.trim(), email: email.text.trim(), phone: phone.text.trim());

      // Ganti dengan token Anda
      final String token = 'Kosong';

      // Gunakan fungsi helper untuk mengirim data
      final response = await MainHttpClient.post('register', data, token);

      print("data" + data.toString());
      if(response['xStatus'] == "0"){
        MainHelperFunction.showAlert("Gagal Registrasi", response['xMessage']);
      }else if(response['xStatus'] == "1"){
        Get.to(() => const RegisterSuccessScreen());   
      }else{
        MainHelperFunction.showAlert("Info", response.toString());
      }


    
      print(response.toString());
      print(username.text.trim());
    }catch(e){
      Exception(e);
    }finally{
      
    }
  }

}