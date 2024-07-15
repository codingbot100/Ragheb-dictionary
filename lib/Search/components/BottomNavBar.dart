import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class CustomeNavBar extends StatefulWidget {
  final List dataList;
  final PageController pageController;

  CustomeNavBar({
    Key? key,
    required this.dataList,
    required this.pageController,
  }) : super(key: key);

  @override
  State<CustomeNavBar> createState() => _CustomeNavBarState();
}

class _CustomeNavBarState extends State<CustomeNavBar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        clipBehavior: Clip.antiAlias,
        height: 70,
        // color: Theme.of(context).bottomAppBarColor,
        shape: CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Image.asset(
                'icons/back.png',
                scale: 4.5,
              ),
            ),
            IconButton(
              onPressed: () {
                if (widget.pageController.page! > 0) {
                  widget.pageController.previousPage(
                    duration: Duration(milliseconds: 400),
                    curve: Curves.fastEaseInToSlowEaseOut,
                  );
                }
              },
              icon: Icon(
                Icons.arrow_back_ios,
                size: 23,
                color: Color.fromRGBO(111, 111, 111, 1),
              ),
            ),
            IconButton(
              onPressed: () {
                if (widget.pageController.page! < widget.dataList.length - 1) {
                  widget.pageController.nextPage(
                    duration: Duration(milliseconds: 400),
                    curve: Curves.fastEaseInToSlowEaseOut,
                  );
                }
              },
              icon: Icon(
                Icons.arrow_forward_ios,
                size: 23,
                color: Color.fromRGBO(111, 111, 111, 1),
              ),
            ),
            IconButton(
              onPressed: () {
                Get.back();
              },
              icon: SvgPicture.asset(
                "svg_images/search_new.svg",
                colorFilter: ColorFilter.mode(
                  Color.fromRGBO(111, 111, 111, 1),
                  BlendMode.srcIn,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
