import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:landing_page_flutter/constant.dart';
import 'package:landing_page_flutter/controllers/menu_controller.dart';
import 'package:landing_page_flutter/models/menu.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class Home extends StatelessWidget {
  Home({super.key});

  final MenuController menuController = Get.put(MenuController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Header(menuController: menuController),
          Obx(
            () => Expanded(
              child: ScrollablePositionedList.builder(
                itemScrollController: menuController.scrollController,
                itemPositionsListener: menuController.positionListener,
                itemCount: menuList.length,
                itemBuilder: (context, index) =>
                    ContentItem(menu: menuList[index]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MenuButton extends StatelessWidget {
  const MenuButton({
    Key? key,
    required this.menu,
    required this.isActive,
    required this.press,
  }) : super(key: key);

  final Menu menu;
  final bool isActive;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: press,
      child: Container(
        margin: const EdgeInsets.only(left: 10),
        padding: const EdgeInsets.only(bottom: 5),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: isActive ? Colors.white : Colors.transparent,
              width: 2,
            ),
          ),
        ),
        child: Text(
          menu.name,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}

class ContentItem extends StatelessWidget {
  const ContentItem({
    Key? key,
    required this.menu,
  }) : super(key: key);

  final Menu menu;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: menu.height,
      color: menu.background,
      child: Center(
        child: Text(
          menu.name,
          style: Theme.of(context).textTheme.displayMedium,
        ),
      ),
    );
  }
}

class Header extends StatelessWidget {
  const Header({
    Key? key,
    required this.menuController,
  }) : super(key: key);

  final MenuController menuController;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      width: double.infinity,
      color: Colors.blue,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Landing Page',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Obx(
            () => Row(
              children: List.generate(
                menuList.length,
                (index) => MenuButton(
                  menu: menuList[index],
                  isActive: index == menuController.activeIndex,
                  press: () => menuController.menuChange(index),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
