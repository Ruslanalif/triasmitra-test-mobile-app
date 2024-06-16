
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:triasmitra_mobile_app/utils/constants/sizes.dart';

class MainLoginForm extends StatelessWidget {
  const MainLoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(child: 
            Padding(
              padding: const EdgeInsets.only(bottom: MainSize.spaceBtwSections),
              child: Column(
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Iconsax.direct_right),
                      labelText: "Username",
              
                    ),
                  ),
                  const SizedBox(height: MainSize.spaceBtwItems,),
                  TextFormField(
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Iconsax.password_check),
                      labelText: "Password",
                      suffixIcon: Icon(Iconsax.eye_slash),
                    ),
                  ),
                  const SizedBox(height: MainSize.spaceBtwSections * 0.7,),
                  SizedBox(width: double.infinity, child: ElevatedButton(onPressed: (){}, child: Text("Login")),),
                  const SizedBox(height: MainSize.spaceBtwItems * 0.8,),
                  SizedBox(width: double.infinity, child: OutlinedButton(onPressed: (){}, child: Text("Register")),),
              
                ],
              ),
            )
          );
  }
}