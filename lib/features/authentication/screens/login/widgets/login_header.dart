
import 'package:flutter/material.dart';
import 'package:triasmitra_mobile_app/utils/constants/image_strings.dart';
import 'package:triasmitra_mobile_app/utils/constants/text_strings.dart';
import 'package:triasmitra_mobile_app/utils/helpers/helper_functions.dart';

class MainLoginHeader extends StatelessWidget {
  const MainLoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = MainHelperFunction.isDarkMode(context);
    return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               Image(
                height: 150,
                image: AssetImage(dark ? MainImages.darkLoginLogo : MainImages.lightAppLogo),
              ),
               Transform.translate(child: Text(MainText.loginTitle, style: Theme.of(context).textTheme.headlineMedium,), offset: const Offset(0, -25),),
               Transform.translate(child: Text(MainText.loginDescribe, style: Theme.of(context).textTheme.bodyMedium,), offset: const Offset(0, -20),),
              // const SizedBox(height: MainSize.sm,),
              
            ],
          );
  }
}