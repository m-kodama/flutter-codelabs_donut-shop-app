import 'package:flutter/material.dart';
import 'package:flutter_codelab_donut_shop_app/ui/core/app_colors.dart';
import 'package:flutter_codelab_donut_shop_app/ui/donut_shop_main/state_holder/donut_bottom_bar_selection_service.dart';
import 'package:provider/provider.dart';

class DonutBottomBar extends StatelessWidget {
  const DonutBottomBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(30),
      child: Consumer<DonutBottomBarSelectionService>(
        builder: (context, bottomBarSelectionService, child) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {
                  bottomBarSelectionService.setTabSelection('main');
                },
                icon: Icon(
                  Icons.trip_origin,
                  color: bottomBarSelectionService.tabSelection == 'main'
                      ? AppColors.mainDark
                      : AppColors.mainColor,
                ),
              ),
              IconButton(
                onPressed: () {
                  bottomBarSelectionService.setTabSelection('favorites');
                },
                icon: Icon(
                  Icons.favorite,
                  color: bottomBarSelectionService.tabSelection == 'favorites'
                      ? AppColors.mainDark
                      : AppColors.mainColor,
                ),
              ),
              IconButton(
                onPressed: () {
                  bottomBarSelectionService.setTabSelection('shoppingCart');
                },
                icon: Icon(
                  Icons.shopping_cart,
                  color:
                      bottomBarSelectionService.tabSelection == 'shoppingCart'
                          ? AppColors.mainDark
                          : AppColors.mainColor,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
