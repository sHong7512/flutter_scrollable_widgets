import 'package:flutter/material.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

/**
 * CustomTabView랑 연동 사용.
 * 빠른 구현을 위해 static 변수로 선언함.
    => 여러 탭바 필요시 static 풀고 객체화 해서 사용하면 됨.
 * @author : sHong (ksh7512@uangel.com)
 * @dependency :
    scroll_to_index: ^3.0.1
    widgets_visibility_provider: ^3.0.1
 */
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
    int initialIndex = 0,
  }) {
    _state = _CustomTabBarState();
    CustomTabBar.initialIndex = initialIndex;
  }

  static bool isTabScrolling = false;

  static int initialIndex = 0;

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
  void initState() {
    super.initState();
    _currentSelectIndex = CustomTabBar.initialIndex;
  }

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
              backgroundColor: index == _currentSelectIndex ? Colors.black : Colors.white),
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
