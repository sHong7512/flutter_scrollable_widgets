import 'package:flutter/material.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

/*
  사용 라이브러리
  scroll_to_index: ^3.0.1
  widgets_visibility_provider: ^3.0.1
 */
//TODO 부드럽게 적용, 잔버그 제거, 범용성 높이기
class CustomTabBar extends StatefulWidget {
  final AutoScrollController tabScrollController;
  final AutoScrollController bodyScrollController;
  final List<Widget> tabs;
  final Duration scrollDuration;

  CustomTabBar({
    Key? key,
    required this.tabScrollController,
    required this.bodyScrollController,
    required this.tabs,
    this.scrollDuration = const Duration(milliseconds: 300),
  }) {
    _state = _CustomTabBarState();
  }

  static bool isTabScrolling = false;

  static AutoScrollPosition autoScrollPosition = AutoScrollPosition.begin;

  static _CustomTabBarState? _state;

  static stateUpdate(int index) {
    _state?.stateUpdate(index);
  }

  @override
  State<CustomTabBar> createState() => _state!;
}

class _CustomTabBarState extends State<CustomTabBar> {
  int _currentSelectIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: widget.tabScrollController,
      scrollDirection: Axis.horizontal,
      child: Row(
        children:
            widget.tabs.asMap().entries.map((entry) => _tabItem(entry.key, entry.value)).toList(),
      ),
    );
  }

  Widget _tabItem(int index, Widget child) {
    return AutoScrollTag(
        key: ValueKey(index),
        controller: widget.tabScrollController,
        index: index,
        child: TextButton(
          style: TextButton.styleFrom(
              backgroundColor: _currentSelectIndex == index ? Colors.black : Colors.white),
          onPressed: () {
            CustomTabBar.isTabScrolling = true;
            stateUpdate(index);
            widget.bodyScrollController.scrollToIndex(
              index,
              duration: widget.scrollDuration,
              preferPosition: CustomTabBar.autoScrollPosition,
            );
            widget.tabScrollController.scrollToIndex(
              index,
              duration: widget.scrollDuration,
              preferPosition: AutoScrollPosition.middle,
            );
          },
          child: child,
        ));
  }

  stateUpdate(int index) async {
    if (mounted) {
      setState(() {
        _currentSelectIndex = index;
      });
    }
  }

  @override
  void dispose() {
    widget.tabScrollController.dispose();
    widget.bodyScrollController.dispose();
    super.dispose();
  }
}
