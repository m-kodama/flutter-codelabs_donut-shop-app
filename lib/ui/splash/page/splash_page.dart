import 'package:flutter/material.dart';
import 'package:flutter_codelab_donut_shop_app/ui/core/app_colors.dart';
import 'package:flutter_codelab_donut_shop_app/ui/core/image_urls.dart';
import 'package:flutter_codelab_donut_shop_app/ui/core/navigation.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  AnimationController? donutController;
  Animation<double>? rotateAnimation;

  @override
  void initState() {
    super.initState();
    donutController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..repeat();

    rotateAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: donutController!,
        curve: Curves.linear,
      ),
    );

    Future.delayed(const Duration(seconds: 2), () {
      Navigation.mainAppNav.currentState!.pushReplacementNamed('/main');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            RotationTransition(
              turns: rotateAnimation!,
              child: Image.network(
                ImageUrls.donutLogoWhiteNoText,
                width: 100,
                height: 100,
              ),
            ),
            Image.network(
              ImageUrls.donutLogoWhiteText,
              width: 150,
              height: 150,
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    donutController?.dispose();
    super.dispose();
  }
}
