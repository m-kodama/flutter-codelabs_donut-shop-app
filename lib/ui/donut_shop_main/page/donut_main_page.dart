import 'package:flutter/material.dart';
import 'package:flutter_codelab_donut_shop_app/ui/donut_shop_main/state_holder/donut_service.dart';
import 'package:flutter_codelab_donut_shop_app/ui/donut_shop_main/widget/donut_filter_bar.dart';
import 'package:flutter_codelab_donut_shop_app/ui/donut_shop_main/widget/donut_list.dart';
import 'package:flutter_codelab_donut_shop_app/ui/donut_shop_main/widget/donut_pager.dart';
import 'package:provider/provider.dart';

class DonutMainPage extends StatelessWidget {
  const DonutMainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        const SliverToBoxAdapter(
          child: DonutPager(),
        ),
        const SliverToBoxAdapter(
          child: DonutFilterBar(),
        ),
        SliverToBoxAdapter(
          child: SizedBox(
            height: 280,
            child: Consumer<DonutService>(
              builder: (context, donutService, child) {
                return DonutList(donuts: donutService.filteredDonuts);
              },
            ),
          ),
        ),
      ],
    );
  }
}
