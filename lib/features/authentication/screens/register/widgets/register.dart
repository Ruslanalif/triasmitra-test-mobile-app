
import 'package:flutter/material.dart';
import 'package:triasmitra_mobile_app/common/widgets/login_register/form_devider.dart';
import 'package:triasmitra_mobile_app/common/widgets/login_register/powered_tools.dart';
import 'package:triasmitra_mobile_app/features/authentication/screens/register/widgets/reggister_form.dart';
import 'package:triasmitra_mobile_app/utils/constants/colors.dart';
import 'package:triasmitra_mobile_app/utils/constants/sizes.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MainColors.primaryColor,
      ),
      body: SingleChildScrollView(
        child: Padding(padding: const EdgeInsets.all(MainSize.defaultSpace), child: Column(
          children: [
            Text("Register", style: Theme.of(context).textTheme.headlineMedium,),
            const SizedBox(height: MainSize.spaceBtwItems * 1.5,),
            const MainRegisterForm(),
            const SizedBox(height: MainSize.spaceBtwItems * 0.7,),
            const MainDeviderForm(dividerText: "Powered Tools",),
            const SizedBox(height: MainSize.spaceBtwSections * 0.7,),
            const MainPoweredTools(),
          ],
        ),),
      ),
    );
  }
}