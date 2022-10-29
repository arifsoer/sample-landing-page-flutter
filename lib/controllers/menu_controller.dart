import 'package:flutter/animation.dart';
import 'package:get/get.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class MenuController extends GetxController {
  final _activeIndex = 0.obs;
  final _customController = ItemScrollController().obs;
  final _controllerListener = ItemPositionsListener.create();

  @override
  void onInit() {
    _controllerListener.itemPositions.addListener(onChangeScroll);
    super.onInit();
  }

  @override
  void onClose() {
    _controllerListener.itemPositions.removeListener(onChangeScroll);
    super.onClose();
  }

  void onChangeScroll() {
    final inScreenIndex = _controllerListener.itemPositions.value
        .where((e) => e.itemTrailingEdge > 0.1)
        .map((e) => e.index)
        .toList();
    _activeIndex(inScreenIndex.first);
  }

  int get activeIndex => _activeIndex.value;

  ItemScrollController get scrollController => _customController.value;
  ItemPositionsListener get positionListener => _controllerListener;

  void menuChange(int index) {
    _customController.value.scrollTo(
      index: index,
      duration: const Duration(milliseconds: 500),
      curve: Curves.ease,
    );
  }
}
