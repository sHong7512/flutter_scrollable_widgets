import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:widgets_visibility_provider/widgets_visibility_provider.dart';

import 'custom_tab_bar.dart';

/**
 * CustomTabBar랑 연동 사용
 * _scrollCasing()의 case(CustomScrollMode.fix)를 조절하여 앱 설계(기획)에 맞춰주는게 좋음
 * @author : sHong (ksh7512@uangel.com)
 * @dependency :
    scroll_to_index: ^3.0.1
    widgets_visibility_provider: ^3.0.1
 */
class CustomTabView extends StatefulWidget {
  CustomTabView({
    Key? key,
    required this.tabScrollController,
    required this.bodyScrollController,
    required this.children,
    this.customScrollMode = CustomScrollMode.first,
    this.blockInitialIndexTabAnimate = true,
  }) : super(key: key);

  final List<Widget> children;
  final AutoScrollController tabScrollController;
  final AutoScrollController bodyScrollController;
  final CustomScrollMode customScrollMode;
  final bool blockInitialIndexTabAnimate;

  @override
  State<CustomTabView> createState() => _CustomTabViewState();
}

class _CustomTabViewState extends State<CustomTabView> {
  final Duration _duration = const Duration(milliseconds: 1);

  List<int> _curIndexList = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if(widget.blockInitialIndexTabAnimate) {
        CustomTabBar.isTabScrolling = true;
      }
      CustomTabBar.autoScrollPosition = AutoScrollPosition.begin;
      widget.bodyScrollController.scrollToIndex(
        CustomTabBar.initialIndex,
        duration: const Duration(milliseconds: 1),
        preferPosition: AutoScrollPosition.begin,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return WidgetsVisibilityProvider(
      child: WidgetsVisibilityListener(
        listener: (context, event) {
          if (event.positionDataList.isNotEmpty) {
            final notification = event.notification;
            if (notification == null) return;

            final List<int> bufIndexList = [];
            for (final e in event.positionDataList) {
              if (e.endPosition - e.startPosition < e.viewportSize - 1 &&
                  (e.startPosition < 0 || e.endPosition > e.viewportSize + 1)) continue;
              bufIndexList.add(int.parse(e.data.toString()));
            }
            if (bufIndexList.isEmpty) return;

            int cnt = 0;
            for (final i in _curIndexList) {
              if (bufIndexList.contains(i)) cnt++;
            }
            if (bufIndexList.length == _curIndexList.length && bufIndexList.length == cnt) {
              log('Same Index is Skip');
              return;
            }
            _curIndexList = bufIndexList;

            if (CustomTabBar.isTabScrolling) return;
            log('${bufIndexList.toString()} :: ${event.notification}');
            _scrollCasing(notification, bufIndexList);
          }
        },
        child: Listener(
          onPointerMove: (event) {
            CustomTabBar.isTabScrolling = false;
          },
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            controller: widget.bodyScrollController,
            itemCount: widget.children.length,
            itemBuilder: (context, index) {
              return _tabViewItem(index, widget.children[index]);
            },
          ),
        ),
      ),
    );
  }

  Widget _tabViewItem(int index, Widget child) {
    return VisibleNotifierWidget(
      data: index,
      child: AutoScrollTag(
        key: ValueKey(index),
        controller: widget.bodyScrollController,
        index: index,
        child: child,
      ),
    );
  }

  _scrollCasing(ScrollNotification notification, List<int> indexList) {
    int index = indexList.first;
    switch (widget.customScrollMode) {
      case CustomScrollMode.first:
        index = indexList.first;
        CustomTabBar.autoScrollPosition = AutoScrollPosition.begin;
        break;
      case CustomScrollMode.last:
        index = indexList.last;
        CustomTabBar.autoScrollPosition = AutoScrollPosition.end;
        break;
      case CustomScrollMode.middle:
        index = indexList.middle;
        CustomTabBar.autoScrollPosition = AutoScrollPosition.middle;
        break;
      case CustomScrollMode.fix:    /// 앱 상황에 맞게 조절 필요
        if (indexList.contains(0)) {
          index = indexList.first;
          CustomTabBar.autoScrollPosition = AutoScrollPosition.begin;
        } else if (indexList.contains(widget.children.length - 1)) {
          index = indexList.last;
          CustomTabBar.autoScrollPosition = AutoScrollPosition.end;
        } else {
          index = indexList.middle;
          CustomTabBar.autoScrollPosition = AutoScrollPosition.middle;
        }
        break;
      case CustomScrollMode.delta:
        if (notification is ScrollUpdateNotification) {
          final double delta = notification.scrollDelta ?? 0;
          log('$delta');
          if (delta >= 0.2) {
            CustomTabBar.stateUpdate(indexList.last);
            widget.tabScrollController.scrollToIndex(indexList.last, duration: _duration);
          } else if (delta <= -0.2) {
            CustomTabBar.stateUpdate(indexList.first);
            widget.tabScrollController.scrollToIndex(indexList.first, duration: _duration);
          }
        }
        return;
      default:
        throw Exception('Not Defined case');
    }

    CustomTabBar.stateUpdate(index);
    widget.tabScrollController.scrollToIndex(
      index,
      duration: _duration,
      preferPosition: AutoScrollPosition.middle,
    );
  }
}

extension _ListMiddleExtension<T> on List {
  T get middle => this[(length / 2).toInt()];
}

enum CustomScrollMode {
  first, // 고정값으로 first 처리
  last, // 고정값으로 last 처리
  middle, // 고정값으로 middle 처리
  fix, // first middle last 합친거
  delta, // 델타값으로 first last 처리
}
