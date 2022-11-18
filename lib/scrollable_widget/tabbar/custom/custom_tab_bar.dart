import 'package:flutter/material.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

import 'custom_tab_card.dart';

/**
 * * CustomTabView, CustomTabCard랑 연동 사용.
 * _scrollCasing()의 case(CustomScrollMode.fix)를 조절하여 앱 설계(기획)에 맞춰주는게 좋음
 * @author : sHong (ksh7512@uangel.com)
 * @dependency : scroll_to_index: ^3.0.1
 */
class CustomTabConnector {
  CustomTabConnector({required List<CustomTabCard> tabs}) {
    customTabBar = CustomTabBar(
      key: tabBarKey,
      tabScrollController: tabScrollController,
      bodyScrollController: bodyScrollController,
      tabs: tabs,
    );
  }
  final GlobalKey<CustomTabBarState> tabBarKey = GlobalKey();
  final AutoScrollController bodyScrollController = AutoScrollController(axis: Axis.vertical);
  final AutoScrollController tabScrollController = AutoScrollController(axis: Axis.horizontal);
  CustomTabBar? customTabBar;
}

class CustomTabBar extends StatefulWidget {
  final AutoScrollController tabScrollController;
  final AutoScrollController bodyScrollController;
  final List<CustomTabCard> tabs;
  final Duration scrollDuration;

  CustomTabBar({
    Key? key,
    required this.tabScrollController,
    required this.bodyScrollController,
    required this.tabs,
    this.scrollDuration = const Duration(milliseconds: 300),
    this.initialIndex = 0,
  }): super(key: key);

  int initialIndex;

  @override
  State<CustomTabBar> createState() => CustomTabBarState();
}

class CustomTabBarState extends State<CustomTabBar> {
  AutoScrollPosition autoScrollPosition = AutoScrollPosition.begin;
  bool isTabScrolling = false;

  int _currentSelectIndex = 0;

  @override
  void initState() {
    super.initState();
    _currentSelectIndex = widget.initialIndex;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      stateUpdate(_currentSelectIndex);
    });
  }

  @override
  Widget build(BuildContext context) {
    stateUpdate(_currentSelectIndex);
    return SingleChildScrollView(
      controller: widget.tabScrollController,
      scrollDirection: Axis.horizontal,
      child: Row(
        children:
        widget.tabs.asMap().entries.map((entry) => _tabItem(entry.key, entry.value)).toList(),
      ),
    );

    /// ListView.builder는 parent의 height를 정해줘야 사용가능
    // return ListView.builder(
    //   shrinkWrap: true,
    //   controller: widget.tabScrollController,
    //   scrollDirection: Axis.horizontal,
    //   itemCount: widget.tabs.length,
    //   itemBuilder: (BuildContext context, int index) => _tabItem(index, widget.tabs[index]),
    // );
  }

  Widget _tabItem(int index, Widget child) {
    return AutoScrollTag(
        key: ValueKey(index),
        controller: widget.tabScrollController,
        index: index,
        child: GestureDetector(
          // style: TextButton.styleFrom(backgroundColor: Colors.transparent),
          onTap: () {
            isTabScrolling = true;
            stateUpdate(index);
            widget.bodyScrollController.scrollToIndex(
              index,
              duration: widget.scrollDuration,
              preferPosition: autoScrollPosition,
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

  stateUpdate(int index) {
    if (mounted) {
      widget.tabs[_currentSelectIndex].cardKey.currentState?.setSelect(false);
      widget.tabs[index].cardKey.currentState?.setSelect(true);
      _currentSelectIndex = index;
    }
  }

  @override
  void dispose() {
    widget.tabScrollController.dispose();
    widget.bodyScrollController.dispose();
    super.dispose();
  }
}
