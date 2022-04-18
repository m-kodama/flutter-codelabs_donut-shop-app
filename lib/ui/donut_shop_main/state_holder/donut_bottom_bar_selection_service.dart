import 'package:flutter/material.dart';
import 'package:flutter_codelab_donut_shop_app/ui/core/navigation.dart';

class DonutBottomBarSelectionService extends ChangeNotifier {
  String? tabSelection = 'main';

  void setTabSelection(String selection) {
    Navigation.mainListNav.currentState!.pushReplacementNamed('/$selection');
    tabSelection = selection;
    notifyListeners();
  }
}
