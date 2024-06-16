import 'package:flutter/material.dart';
import 'package:triasmitra_mobile_app/common/styles/spacing_styles.dart';
import 'package:triasmitra_mobile_app/common/widgets/login_register/form_devider.dart';
import 'package:triasmitra_mobile_app/common/widgets/login_register/powered_tools.dart';
import 'package:triasmitra_mobile_app/features/authentication/screens/login/widgets/login_form.dart';
import 'package:triasmitra_mobile_app/features/authentication/screens/login/widgets/login_header.dart';
import 'package:triasmitra_mobile_app/utils/constants/sizes.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return const Scaffold(
      body:  SingleChildScrollView(
        child: Padding(
          padding: MainSpacingStyle.paddingWithAppBarHeight,
          child:  Column(
            children: [ 
               MainLoginHeader(),
              // form
               MainLoginForm(),
               MainDeviderForm(dividerText: "Let's do Something!",),
               SizedBox(height: MainSize.spaceBtwSections * 0.7,),
               MainPoweredTools(),
            ],
          ),
        ),
      ),
    );
  }
}