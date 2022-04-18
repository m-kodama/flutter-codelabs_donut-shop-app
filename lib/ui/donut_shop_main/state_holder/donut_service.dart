import 'package:flutter/material.dart';
import 'package:flutter_codelab_donut_shop_app/ui/donut_shop_main/state_holder/mock_data.dart';
import 'package:flutter_codelab_donut_shop_app/ui/donut_shop_main/state_holder/state/donut_model.dart';

class DonutService extends ChangeNotifier {
  List<DonutFilterBarItem> filterBarItems = [
    const DonutFilterBarItem(id: 'classic', label: 'Classic'),
    const DonutFilterBarItem(id: 'sprinkled', label: 'Sprinkled'),
    const DonutFilterBarItem(id: 'stuffed', label: 'Stuffed'),
  ];
  String? selectedDonutType;
  List<DonutModel> filteredDonuts = [];

  DonutService() {
    selectedDonutType = filterBarItems.first.id;
    filteredDonutsByType(selectedDonutType!);
  }

  void filteredDonutsByType(String type) {
    selectedDonutType = type;
    filteredDonuts = donuts.where((d) => d.type == selectedDonutType).toList();
    notifyListeners();
  }
}

class DonutFilterBarItem {
  final String id;
  final String label;

  const DonutFilterBarItem({
    required this.id,
    required this.label,
  });
}
