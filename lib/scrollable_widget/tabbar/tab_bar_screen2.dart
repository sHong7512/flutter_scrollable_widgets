import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:scrollable_widgets/const/environment.dart';

import '../../const/colors.dart';

//TODO tabbar 스크롤 연결해주기 (라이브러리를 찾든 뭘 해보자)
// TODO https://pub.dev/packages/visibility_detector 이거 함 써보자
class TabBarScreen2 extends StatefulWidget {
  const TabBarScreen2({Key? key}) : super(key: key);

  @override
  State<TabBarScreen2> createState() => _TabBarScreen2State();
}

class _TabBarScreen2State extends State<TabBarScreen2> with SingleTickerProviderStateMixin {
  late TabController _tabController = TabController(length: miniNumbers.length, vsync: this);
  late AutoScrollController _scrollController = AutoScrollController(
      viewportBoundaryGetter: () => Rect.fromLTRB(0, 0, 0, MediaQuery.of(context).padding.bottom),
      axis: Axis.vertical
  );

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TabBarView2 Screen'),
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          onTap: (page) {
            log('page :::: $page');
            _scrollController.scrollToIndex(page);
          },
          tabs: miniNumbers.map((e) => Tab(text: '$e')).toList(),
        ),
      ),

      body: NotificationListener<ScrollNotification>(
        onNotification: (noti){
          log(':: ${noti}');
          log('offset :: ${_scrollController.offset} keys :: ${_scrollController.tagMap.keys}');

          return false;
        },
        child: ListView.builder(
          itemCount: miniNumbers.length,
          controller: _scrollController,
          itemBuilder: (context, index) {
            return AutoScrollTag(
              key: ValueKey(index),
              controller: _scrollController,
              index: index,
              child: renderContainer(
                color: rainbowColors[index % rainbowColors.length],
                index: index,
              ),
            );
          },
        ),
      ),
    );
  }

  _getPosition(GlobalKey key) {
    if (key.currentContext != null) {
      final RenderBox renderBox =
      key.currentContext!.findRenderObject() as RenderBox;
      final position = renderBox.localToGlobal(Offset.zero);
      return position;
    }
  }

}
