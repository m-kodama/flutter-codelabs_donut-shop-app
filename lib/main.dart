import 'package:flutter/material.dart';
import 'package:flutter_codelab_donut_shop_app/ui/core/navigation.dart';
import 'package:flutter_codelab_donut_shop_app/ui/donut_shop_main/page/donut_shop_details.dart';
import 'package:flutter_codelab_donut_shop_app/ui/donut_shop_main/page/donut_shop_main.dart';
import 'package:flutter_codelab_donut_shop_app/ui/donut_shop_main/state_holder/donut_bottom_bar_selection_service.dart';
import 'package:flutter_codelab_donut_shop_app/ui/donut_shop_main/state_holder/donut_service.dart';
import 'package:flutter_codelab_donut_shop_app/ui/donut_shop_main/state_holder/donut_shopping_cart_service.dart';
import 'package:flutter_codelab_donut_shop_app/ui/splash/page/splash_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => DonutBottomBarSelectionService(),
        ),
        ChangeNotifierProvider(
          create: (_) => DonutService(),
        ),
        ChangeNotifierProvider(
          create: (_) => DonutShoppingCartService(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        navigatorKey: Navigation.mainAppNav,
        routes: {
          '/': (context) => const SplashPage(),
          '/main': (context) => const DonutShopMain(),
          '/details': (context) => const DonutShopDetails(),
        },
      ),
    );
  }
}
