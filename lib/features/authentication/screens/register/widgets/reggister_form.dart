
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:triasmitra_mobile_app/features/authentication/controllers/register_controller.dart';
import 'package:triasmitra_mobile_app/utils/constants/sizes.dart';
import 'package:triasmitra_mobile_app/utils/validators/validators.dart';

class MainRegisterForm extends StatelessWidget {
  const MainRegisterForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RegisterController());
    return Form(
              key: controller.registerFormKey,
              child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: controller.firstName,
                        validator: (value) => MainValidator.isRequired(value, 'Nama Depan'),
                        
                        decoration: const InputDecoration(
                          labelText: "Nama Depan",
                          prefixIcon: Icon(Iconsax.user)
                        ),
                      ),
                    ),
                    const SizedBox(width: MainSize.spaceBtwItems * 0.5,),
                    Expanded(
                      child: TextFormField(
                        controller: controller.lastName, 
                        validator: (value) => MainValidator.isRequired(value, 'Nama Belakang'),
                        
                        decoration: const InputDecoration(
                          labelText: "Nama Belakang",
                          prefixIcon: Icon(Iconsax.user)
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: MainSize.spaceBtwItems * 0.7,),
                TextFormField(
                  controller: controller.username,
                  validator: (value) => MainValidator.isRequired(value, 'Username'),
                  
                  decoration: const InputDecoration(
                    labelText: "Username",
                    prefixIcon: Icon(Iconsax.direct_right)
                  ),
                ),
                const SizedBox(height: MainSize.spaceBtwItems * 0.7,),
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
                const SizedBox(height: MainSize.spaceBtwItems * 0.7,),
                TextFormField(
                  controller: controller.email,
                  validator: (value) => MainValidator.isRequired(value, 'Email'),
                  
                  decoration: const InputDecoration(
                    labelText: "Email",
                    prefixIcon: Icon(Iconsax.message)
                  ),
                ),
                const SizedBox(height: MainSize.spaceBtwItems * 0.7,),
                TextFormField(
                  controller: controller.phone,
                  validator: (value) => MainValidator.isRequired(value, 'Phone'),
                  
                  decoration: const InputDecoration(
                    labelText: "Phone",
                    prefixIcon: Icon(Iconsax.user)
                  ),
                ),
                const SizedBox(height: MainSize.spaceBtwItems * 0.7,),
                SizedBox(width: double.infinity, child: ElevatedButton(onPressed: () => controller.register(), child: const Text("Register")),),
              ],
            ));
  }
}