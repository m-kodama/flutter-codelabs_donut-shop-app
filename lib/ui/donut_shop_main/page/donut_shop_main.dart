import 'package:flutter/material.dart';
import 'package:flutter_codelab_donut_shop_app/ui/core/app_colors.dart';
import 'package:flutter_codelab_donut_shop_app/ui/core/image_urls.dart';
import 'package:flutter_codelab_donut_shop_app/ui/core/navigation.dart';
import 'package:flutter_codelab_donut_shop_app/ui/donut_shop_main/page/donut_main_page.dart';
import 'package:flutter_codelab_donut_shop_app/ui/donut_shop_main/widget/donut_bottom_bar.dart';
import 'package:flutter_codelab_donut_shop_app/ui/donut_shop_main/widget/donut_side_menu.dart';

class DonutShopMain extends StatelessWidget {
  const DonutShopMain({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Drawer(
        child: DonutSideMenu(),
      ),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: AppColors.mainDark),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Image.network(ImageUrls.donutLogoRedText, width: 120),
      ),
      body: Column(
        children: [
          // メイン部分
          Expanded(
            child: Navigator(
              key: Navigation.mainListNav,
              initialRoute: '/main',
              onGenerateRoute: (RouteSettings settings) {
                Widget page;
                switch (settings.name) {
                  case '/main':
                    page = const DonutMainPage();
                    break;
                  case '/favorites':
                    page = Center(child: Text('favorites'));
                    break;
                  case '/shoppingCart':
                    page = Center(child: Text('shoppingCart'));
                    break;
                  default:
                    page = const DonutMainPage();
                    break;
                }

                return PageRouteBuilder(
                  pageBuilder: (_, __, ___) => page,
                  transitionDuration: const Duration(seconds: 0),
                );
              },
            ),
          ),
          // ボトムナビゲーションバー
          const DonutBottomBar(),
        ],
      ),
    );
  }
}
