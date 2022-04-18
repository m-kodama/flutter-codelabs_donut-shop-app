import 'package:flutter/material.dart';
import 'package:flutter_codelab_donut_shop_app/ui/core/app_colors.dart';
import 'package:flutter_codelab_donut_shop_app/ui/core/image_urls.dart';

class DonutPager extends StatefulWidget {
  const DonutPager({Key? key}) : super(key: key);

  @override
  State<DonutPager> createState() => DonutPagerState();
}

class DonutPagerState extends State<DonutPager> {
  List<_DonutPage> pages = [
    const _DonutPage(
      imageUrl: ImageUrls.donutPromo1,
      logoImgUrl: ImageUrls.donutLogoWhiteText,
    ),
    const _DonutPage(
      imageUrl: ImageUrls.donutPromo2,
      logoImgUrl: ImageUrls.donutLogoWhiteText,
    ),
    const _DonutPage(
      imageUrl: ImageUrls.donutPromo3,
      logoImgUrl: ImageUrls.donutLogoRedText,
    ),
  ];

  int currentPage = 0;
  PageController? controller;

  @override
  void initState() {
    super.initState();
    controller = PageController(initialPage: 0);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350,
      child: Column(
        children: [
          Expanded(
            child: PageView(
              scrollDirection: Axis.horizontal,
              pageSnapping: true,
              controller: controller,
              onPageChanged: (int page) {
                setState(() {
                  currentPage = page;
                });
              },
              children: List.generate(
                pages.length,
                (index) {
                  final currentPage = pages[index];
                  return Container(
                    alignment: Alignment.bottomLeft,
                    margin: const EdgeInsets.all(20),
                    padding: const EdgeInsets.all(30),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 10,
                          offset: const Offset(0.0, 5.0),
                        )
                      ],
                      image: DecorationImage(
                        image: NetworkImage(currentPage.imageUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Image.network(
                      currentPage.logoImgUrl,
                      width: 120,
                    ),
                  );
                },
              ),
            ),
          ),
          _PageViewIndicator(
            controller: controller,
            numberOfPages: pages.length,
            currentPage: currentPage,
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}

class _DonutPage {
  const _DonutPage({
    required this.imageUrl,
    required this.logoImgUrl,
  });

  final String imageUrl;
  final String logoImgUrl;
}

class _PageViewIndicator extends StatelessWidget {
  const _PageViewIndicator({
    this.controller,
    required this.numberOfPages,
    required this.currentPage,
    Key? key,
  }) : super(key: key);

  final PageController? controller;
  final int numberOfPages;
  final int currentPage;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        numberOfPages,
        (index) {
          return GestureDetector(
            onTap: () {
              controller?.animateToPage(
                index,
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
              );
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeInOut,
              width: 15,
              height: 15,
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: currentPage == index
                    ? AppColors.mainColor
                    : Colors.grey.withOpacity(0.2),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          );
        },
      ),
    );
  }
}
