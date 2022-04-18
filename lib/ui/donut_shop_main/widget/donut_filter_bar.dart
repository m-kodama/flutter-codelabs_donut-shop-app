import 'package:flutter/material.dart';
import 'package:flutter_codelab_donut_shop_app/ui/core/app_colors.dart';
import 'package:flutter_codelab_donut_shop_app/ui/donut_shop_main/state_holder/donut_service.dart';
import 'package:provider/provider.dart';

class DonutFilterBar extends StatelessWidget {
  const DonutFilterBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Consumer<DonutService>(
        builder: (context, donutService, child) {
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(
                  donutService.filterBarItems.length,
                  (index) {
                    final item = donutService.filterBarItems[index];

                    return GestureDetector(
                      onTap: () {
                        donutService.filteredDonutsByType(item.id);
                      },
                      child: Container(
                        child: Text(
                          item.label,
                          style: TextStyle(
                              color: donutService.selectedDonutType == item.id
                                  ? AppColors.mainColor
                                  : Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 10),
              Stack(
                children: [
                  AnimatedAlign(
                    alignment:
                        alignmentBasedOnTap(donutService.selectedDonutType),
                    duration: const Duration(milliseconds: 250),
                    curve: Curves.easeInOut,
                    child: Container(
                      width: MediaQuery.of(context).size.width / 3 - 20,
                      height: 5,
                      decoration: BoxDecoration(
                        color: AppColors.mainColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ],
              )
            ],
          );
        },
      ),
    );
  }

  Alignment alignmentBasedOnTap(String? filterBarId) {
    switch (filterBarId) {
      case 'classic':
        return Alignment.centerLeft;
      case 'sprinkled':
        return Alignment.center;
      case 'stuffed':
        return Alignment.centerRight;
      default:
        return Alignment.centerLeft;
    }
  }
}
