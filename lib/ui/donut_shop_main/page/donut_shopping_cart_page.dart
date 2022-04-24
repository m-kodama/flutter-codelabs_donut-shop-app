import 'package:flutter/material.dart';
import 'package:flutter_codelab_donut_shop_app/ui/core/app_colors.dart';
import 'package:flutter_codelab_donut_shop_app/ui/core/image_urls.dart';
import 'package:flutter_codelab_donut_shop_app/ui/donut_shop_main/state_holder/donut_shopping_cart_service.dart';
import 'package:flutter_codelab_donut_shop_app/ui/donut_shop_main/state_holder/state/donut_model.dart';
import 'package:provider/provider.dart';

class DonutShoppingCartPage extends StatefulWidget {
  const DonutShoppingCartPage({Key? key}) : super(key: key);

  @override
  State<DonutShoppingCartPage> createState() => _DonutShoppingCartPageState();
}

class _DonutShoppingCartPageState extends State<DonutShoppingCartPage>
    with TickerProviderStateMixin {
  AnimationController? titleAnimation;
  AnimationController? totalPriceAnimation;

  final GlobalKey<SliverAnimatedListState> _key = GlobalKey();
  final List<DonutModel> _insertedItems = [];

  @override
  void initState() {
    super.initState();

    titleAnimation = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    )..forward();

    totalPriceAnimation = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    )..forward();

    final cartService =
        Provider.of<DonutShoppingCartService>(context, listen: false);

    var future = Future(() {});
    for (var i = 0; i < cartService.cartDonuts.length; i++) {
      future = future.then((_) {
        return Future.delayed(const Duration(milliseconds: 150), () {
          _insertedItems.add(cartService.cartDonuts[i]);
          _key.currentState!.insertItem(
            i,
            duration: const Duration(milliseconds: 300),
          );
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final cartService =
        Provider.of<DonutShoppingCartService>(context, listen: true);

    return CustomScrollView(
      physics: cartService.cartDonuts.isEmpty
          ? const NeverScrollableScrollPhysics()
          : const AlwaysScrollableScrollPhysics(),
      slivers: [
        // タイトル
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(40, 40, 40, 0),
          sliver: SliverToBoxAdapter(
            child: Align(
              alignment: Alignment.centerLeft,
              child: FadeTransition(
                opacity: Tween(begin: 0.0, end: 1.0).animate(
                  CurvedAnimation(
                    parent: titleAnimation!,
                    curve: Curves.easeInOut,
                  ),
                ),
                child: Image.network(
                  ImageUrls.donutTitleMyDonuts,
                  width: 170,
                ),
              ),
            ),
          ),
        ),
        // エンプティシート
        if (cartService.cartDonuts.isEmpty)
          SliverFillRemaining(
            hasScrollBody: false,
            child: Center(
              child: SizedBox(
                width: 200,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.shopping_cart,
                      color: Colors.grey[300],
                      size: 50,
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'You don\'t have any items on your cart yet!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        // 商品リスト
        if (cartService.cartDonuts.isNotEmpty)
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(40, 40, 40, 0),
            sliver: SliverAnimatedList(
              key: _key,
              initialItemCount: _insertedItems.length,
              itemBuilder: (context, index, animation) {
                final currentDonut = cartService.cartDonuts[index];
                return SlideTransition(
                  position: Tween(
                    begin: const Offset(1, 0.0),
                    end: const Offset(0.0, 0.0),
                  ).animate(
                    CurvedAnimation(
                      parent: animation,
                      curve: Curves.easeOut,
                    ),
                  ),
                  child: FadeTransition(
                    opacity: Tween(
                      begin: 0.0,
                      end: 1.0,
                    ).animate(
                      CurvedAnimation(
                        parent: animation,
                        curve: Curves.easeInOut,
                      ),
                    ),
                    child: _DonutShoppingListRow(
                      donut: currentDonut,
                      onDeleteRow: () {
                        cartService.removeFromCart(currentDonut);
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        // 合計金額
        if (cartService.cartDonuts.isNotEmpty)
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(40, 40, 40, 40),
            sliver: SliverToBoxAdapter(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // 合計金額
                  Column(
                    children: [
                      const Text(
                        'Total',
                        style: TextStyle(
                          color: AppColors.mainDark,
                        ),
                      ),
                      Text(
                        '\$${cartService.getTotal().toStringAsFixed(2)}',
                        style: const TextStyle(
                          color: AppColors.mainDark,
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        ),
                      )
                    ],
                  ),
                  // カートクリアボタン
                  ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Material(
                      color: AppColors.mainColor.withOpacity(0.2),
                      child: InkWell(
                        splashColor: AppColors.mainDark.withOpacity(0.2),
                        highlightColor: AppColors.mainDark.withOpacity(0.5),
                        onTap: () {
                          cartService.clearCart();
                        },
                        child: Container(
                          padding: const EdgeInsets.only(
                            top: 10,
                            bottom: 10,
                            left: 20,
                            right: 20,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: const [
                              Icon(
                                Icons.delete_forever,
                                color: AppColors.mainDark,
                              ),
                              Text(
                                'Clear Cart',
                                style: TextStyle(
                                  color: AppColors.mainDark,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }

  @override
  void dispose() {
    titleAnimation?.dispose();
    totalPriceAnimation?.dispose();

    super.dispose();
  }
}

/// ドーナッツリスト
class _DonutShoppingListRow extends StatelessWidget {
  const _DonutShoppingListRow({
    required this.donut,
    required this.onDeleteRow,
    Key? key,
  }) : super(key: key);

  final DonutModel donut;
  final Function onDeleteRow;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 10, right: 20),
      child: Row(
        children: [
          Image.network(donut.imgUrl, width: 80, height: 80),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  donut.name,
                  style: const TextStyle(
                    color: AppColors.mainDark,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Container(
                  padding: const EdgeInsets.only(
                    top: 5,
                    bottom: 5,
                    left: 10,
                    right: 10,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      width: 2,
                      color: AppColors.mainDark.withOpacity(0.2),
                    ),
                  ),
                  child: Text(
                    '\$${donut.price.toStringAsFixed(2)}',
                    style: TextStyle(
                      color: AppColors.mainDark.withOpacity(0.4),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          IconButton(
            onPressed: () {
              onDeleteRow();
            },
            icon: const Icon(
              Icons.delete_forever,
              color: AppColors.mainColor,
            ),
          ),
        ],
      ),
    );
  }
}
