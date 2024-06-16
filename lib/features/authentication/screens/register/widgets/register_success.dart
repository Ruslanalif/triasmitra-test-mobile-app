
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:triasmitra_mobile_app/common/styles/spacing_styles.dart';
import 'package:triasmitra_mobile_app/features/authentication/screens/login/widgets/login.dart';
import 'package:triasmitra_mobile_app/utils/constants/image_strings.dart';
import 'package:triasmitra_mobile_app/utils/constants/sizes.dart';
import 'package:triasmitra_mobile_app/utils/helpers/helper_functions.dart';

class RegisterSuccessScreen extends StatelessWidget {
  const RegisterSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: MainSpacingStyle.paddingWithAppBarHeight,
          child: Column(
            children: [
              Image(image: AssetImage(MainImages.paperFly), width: MainHelperFunction.screenWidth() * 0.6,),
              const SizedBox(height: MainSize.spaceBtwSections,),
              Text("Registrasi Berhasil. Let's \ndo Something!",  style: Theme.of(context).textTheme.headlineMedium,textAlign: TextAlign.center,),
              const SizedBox(height: MainSize.spaceBtwItems * 0.5,),
              Text("Anda dapat Mengelola data ID Card. Coba mulai \n dengan meng upload ID Card Anda!",  style: Theme.of(context).textTheme.labelMedium,textAlign: TextAlign.center,),
              const SizedBox(height: MainSize.spaceBtwSections,),
              SizedBox(width: double.infinity, child: ElevatedButton(onPressed: () => Get.to(()=> const LoginScreen()), child: const Text("Login Sekarang!")),),
            ],
          ),
        ),
      ),
    );
  }
}