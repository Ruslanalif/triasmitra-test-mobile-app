
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:triasmitra_mobile_app/features/authentication/controllers/login_controller.dart';
import 'package:triasmitra_mobile_app/features/authentication/screens/register/widgets/register.dart';
import 'package:triasmitra_mobile_app/utils/constants/sizes.dart';
import 'package:triasmitra_mobile_app/utils/validators/validators.dart';

class MainLoginForm extends StatelessWidget {
  const MainLoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    return Form(
            key: controller.loginFormKey,
            child: Padding(
              padding: const EdgeInsets.only(bottom: MainSize.spaceBtwSections),
              child: Column(
                children: [
                  const SizedBox(height: MainSize.spaceBtwItems * 0.7,),
                  TextFormField(
                    controller: controller.username,
                    validator: (value) => MainValidator.isRequired(value, 'Username'),
                    
                    decoration: const InputDecoration(
                      labelText: "Username",
                      prefixIcon: Icon(Iconsax.direct_right)
                    ),
                  ),
                  const SizedBox(height: MainSize.spaceBtwItems * 0.9,),
                  Obx(
                    () => TextFormField(
                      controller: controller.password,
                      validator: (value) => MainValidator.isRequired(value, 'Password'),
                      obscureText: controller.hidePassword.value,
                      decoration: InputDecoration(
                        labelText: "Password",
                        prefixIcon: const  Icon(Iconsax.password_check),
                        suffixIcon: IconButton(
                          onPressed: () => controller.hidePassword.value = !controller.hidePassword.value, 
                          icon: controller.hidePassword.value ? const Icon(Iconsax.eye) : const Icon(Iconsax.eye_slash)
                        )
                      ),
                    ),
                  ),
                  const SizedBox(height: MainSize.spaceBtwSections * 0.7,),
                  SizedBox(width: double.infinity, child: ElevatedButton(onPressed: () => controller.login(), child: Text("Login")),),
                  const SizedBox(height: MainSize.spaceBtwItems * 0.8,),
                  SizedBox(width: double.infinity, child: OutlinedButton(onPressed: () => Get.to(() => const RegisterScreen()), child: Text("Register")),),
              
                ],
              ),
            )
          );
  }
}