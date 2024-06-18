import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:triasmitra_mobile_app/navigation_menu.dart';
import 'package:triasmitra_mobile_app/utils/helpers/helper_functions.dart';
import 'package:triasmitra_mobile_app/utils/http/http_client.dart';

class MsResidentController extends GetxController {

  static MsResidentController get instance => Get.find();

  final hidePassword = true.obs;
  final idCardNumber = TextEditingController();
  final name = TextEditingController();
  final birthPlace = TextEditingController();
  final birthDay = TextEditingController();
  final gender = TextEditingController();
  final province = TextEditingController();
  final regency = TextEditingController();
  final district = TextEditingController();
  final village = TextEditingController();
  final address = TextEditingController();
  final religion = TextEditingController();
  final maritalStatus = TextEditingController();
  final employment = TextEditingController();
  final citizenship = TextEditingController();
  final fileUrl = TextEditingController();
  final fgActive = TextEditingController();
  final userId = TextEditingController();

  GlobalKey<FormState> msResidentFormKey = GlobalKey<FormState>();

  Future<void> store(bool addMode, String pkId, String prmToken, String prmUserID, dynamic _image, dynamic selectedProvince, dynamic selectedRegency, dynamic selectedDistrict, dynamic selectedVillage, dynamic selectedGender, dynamic birthDate ) async {
    
    print(selectedVillage);
    print(addMode);
    try {
      if (!msResidentFormKey.currentState!.validate()) return;

      // LoginModel(id: "1", firstName: firstName.text.trim(), lastName: lastName.text.trim(), username: username.text.trim(), password: password.text.trim(), email: email.text.trim(), phone: phone.text.trim());
      final Map<String, String> data = {
        'IDCardNumber': idCardNumber.text.trim(),
        'Name': name.text.trim(),
        'BirthPlace': birthPlace.text.trim(),
        'BirthDay': birthDate.trim(),
        'Gender': selectedGender.trim(),
        'Province': selectedProvince.trim(),
        'Regency': selectedRegency.trim(),
        'District': selectedDistrict.trim(),
        'Village': selectedVillage.trim(),
        'Address': address.text.trim(),
        'Religion': religion.text.trim(),
        'MaritalStatus': maritalStatus.text.trim(),
        'Employment': employment.text.trim(),
        'Citizenship': citizenship.text.trim(),
        // 'FileUrl': gender.text.trim(),
        'FgActive': "Y",
        'UserID': prmUserID,
      };
      // final Map<String, String> data = LoginModel(id: 1, firstName: firstName.text.trim(), lastName: lastName.text.trim(), username: username.text.trim(), password: password.text.trim(), email: email.text.trim(), phone: phone.text.trim());

      final String token = prmToken;

      // Gunakan fungsi helper untuk mengirim data
      final response = (_image != null) ? await MainHttpClient.postwImage(addMode ? 'msresidents/store' : 'msresidents/store/$pkId', data, token, _image) : await MainHttpClient.post(addMode ? 'msresidents/store' : 'msresidents/store/$pkId', data, token);

      if (response['xStatus'] == "0") {
        MainHelperFunction.showAlert("Gagal Add Data", response['xMessage']);
      } else if (response['xStatus'] == "1") {
        Get.to(() => NavigationMenu());
      } else {
        MainHelperFunction.showAlert("Info", response.toString());
      }
    } catch (e) {
      Exception(e);
    } finally {}
  }
}
