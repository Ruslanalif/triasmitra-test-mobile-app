

import 'package:flutter/material.dart';
import 'package:triasmitra_mobile_app/utils/constants/image_strings.dart';
import 'package:triasmitra_mobile_app/utils/constants/sizes.dart';

class MainPoweredTools extends StatelessWidget {
  const MainPoweredTools({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 45,
                width: 45,
                decoration: BoxDecoration(border: Border.all(color: Colors.grey), borderRadius: BorderRadius.circular(100)),
                child: IconButton(onPressed: (){}, icon: 
                  const Image(image: AssetImage(MainImages.icMysql), width: MainSize.iconMd * 1.2, height: MainSize.iconMd * 1.2,)
                ),
              ),
              const SizedBox(width: MainSize.spaceBtwItems,),
              Container(
                height: 45,
                width: 45,
                decoration: BoxDecoration(border: Border.all(color: Colors.grey), borderRadius: BorderRadius.circular(100)),
                child: IconButton(onPressed: (){}, icon: 
                  const Image(image: AssetImage(MainImages.icFlutter), width: MainSize.iconMd * 1.2, height: MainSize.iconMd * 1.2,)
                ),
              ),
              const SizedBox(width: MainSize.spaceBtwItems,),
              Container(
                height: 45,
                width: 45,
                decoration: BoxDecoration(border: Border.all(color: Colors.grey), borderRadius: BorderRadius.circular(100)),
                child: IconButton(onPressed: (){}, icon: 
                  const Image(image: AssetImage(MainImages.icLaravel), width: MainSize.iconMd * 1.2, height: MainSize.iconMd * 1.2,)
                ),
              ),
            ],
          );
  }
}