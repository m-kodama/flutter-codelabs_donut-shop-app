import 'package:flutter/material.dart';
import 'package:flutter_codelab_donut_shop_app/ui/core/app_colors.dart';
import 'package:flutter_codelab_donut_shop_app/ui/donut_shop_main/state_holder/donut_shopping_cart_service.dart';
import 'package:provider/provider.dart';

class DonutShoppingCartBadge extends StatelessWidget {
  const DonutShoppingCartBadge({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<DonutShoppingCartService>(
      builder: (context, cartService, child) {
        if (cartService.cartDonuts.isEmpty) {
          return const SizedBox.shrink();
        }

        return Transform.scale(
          scale: 0.7,
          child: Container(
            margin: const EdgeInsets.only(right: 10),
            padding: const EdgeInsets.only(left: 20, right: 20),
            decoration: BoxDecoration(
              color: AppColors.mainColor,
              borderRadius: BorderRadius.circular(40),
            ),
            child: Row(
              children: [
                Text(
                  '${cartService.cartDonuts.length}',
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 10),
                const Icon(
                  Icons.shopping_cart,
                  size: 25,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
