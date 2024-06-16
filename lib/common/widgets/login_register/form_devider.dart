

import 'package:flutter/material.dart';
import 'package:triasmitra_mobile_app/utils/helpers/helper_functions.dart';

class MainDeviderForm extends StatelessWidget {
  const MainDeviderForm({super.key, required this.dividerText});

  final String dividerText;

  @override
  Widget build(BuildContext context) {

    final dark = MainHelperFunction.isDarkMode(context);
    return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(child: Divider(color: dark ? const Color.fromARGB(255, 71, 71, 71) : Colors.grey, thickness: 0.5, indent: 60, endIndent: 5,)),
              Text(dividerText, style: Theme.of(context).textTheme.labelMedium,), 
              Flexible(child: Divider(color: dark ? const Color.fromARGB(255, 71, 71, 71) : Colors.grey, thickness: 0.5, indent: 5, endIndent: 60,))
            ],
          );
  }
}