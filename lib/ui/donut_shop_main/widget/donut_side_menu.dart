import 'package:flutter/material.dart';
import 'package:flutter_codelab_donut_shop_app/ui/core/app_colors.dart';
import 'package:flutter_codelab_donut_shop_app/ui/core/image_urls.dart';

class DonutSideMenu extends StatelessWidget {
  const DonutSideMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.mainDark,
      padding: const EdgeInsets.all(40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
              margin: const EdgeInsets.only(top: 40),
              child: Image.network(
                ImageUrls.donutLogoWhiteNoText,
                width: 100,
              )),
          Image.network(
            ImageUrls.donutLogoWhiteText,
            width: 150,
          ),
        ],
      ),
    );
  }
}
