import 'package:flutter/cupertino.dart';
import 'package:flutter_codelab_donut_shop_app/ui/donut_shop_main/state_holder/state/donut_model.dart';

class DonutShoppingCartService extends ChangeNotifier {
  List<DonutModel> cartDonuts = [];

  void addToCart(DonutModel donut) {
    cartDonuts.add(donut);
    notifyListeners();
  }

  void removeFromCart(DonutModel donut) {
    cartDonuts.removeWhere((d) => d.name == donut.name);
    notifyListeners();
  }

  void clearCart() {
    cartDonuts.clear();
    notifyListeners();
  }

  double getTotal() {
    return cartDonuts.fold(
      0.0,
      (previousValue, donut) => previousValue + donut.price,
    );
  }

  bool isDonutInCart(DonutModel donut) {
    return cartDonuts.any((d) => d.name == donut.name);
  }
}
