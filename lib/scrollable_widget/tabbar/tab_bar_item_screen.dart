import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:scrollable_widgets/const/colors.dart';
import 'package:scrollable_widgets/const/environment.dart';
import 'package:vertical_scrollable_tabview/vertical_scrollable_tabview.dart';

import 'package:scroll_to_index/scroll_to_index.dart' show AutoScrollController;

import 'custom/custom_tab_bar.dart';
import 'custom/custom_tab_view.dart';

class TabBarItemScreen extends StatefulWidget {
  final int index;
  final String name;

  const TabBarItemScreen({
    Key? key,
    required this.index,
    required this.name,
  }) : super(key: key);

  @override
  State<TabBarItemScreen> createState() => _TabBarItemScreenState();
}

class _TabBarItemScreenState extends State<TabBarItemScreen> with SingleTickerProviderStateMixin {
  late final TabController _tabController0 = TabController(length: miniNumbers.length, vsync: this);
  late final TabController _tabController1 = TabController(length: miniNumbers.length, vsync: this);
  late final AutoScrollController _bodyScrollController = AutoScrollController(axis: Axis.vertical);
  late final AutoScrollController _tabScrollController = AutoScrollController(axis: Axis.horizontal);

  @override
  Widget build(BuildContext context) {
    return getWidget(widget.index);
  }

  Widget getWidget(int index) {
    switch (index) {
      case 0:
        return Scaffold(
          appBar: AppBar(
            title: Text(widget.name),
            bottom: TabBar(
              controller: _tabController0,
              isScrollable: true,
              onTap: (page) => log('$page'),
              tabs: miniNumbers.map((e) => Tab(text: '$e')).toList(),
            ),
          ),
          body: TabBarView(
            controller: _tabController0,
            children: miniNumbers
                .map((e) =>
                    renderContainer(color: rainbowColors[e % rainbowColors.length], index: e))
                .toList(),
          ),
        );
      case 1:
        return Scaffold(
          backgroundColor: Colors.white,
          body: VerticalScrollableTabView(
            tabController: _tabController1,
            listItemData: miniNumbers,
            verticalScrollPosition: VerticalScrollPosition.end,
            eachItemChild: (object, index) =>
                renderContainer(color: rainbowColors[index % rainbowColors.length], index: index),
            slivers: [
              SliverAppBar(
                title: Text(widget.name),
                pinned: true,
                bottom: TabBar(
                  isScrollable: true,
                  controller: _tabController1,
                  indicatorPadding: const EdgeInsets.symmetric(horizontal: 16.0),
                  indicatorColor: Colors.black,
                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.white,
                  indicatorWeight: 3.0,
                  tabs: miniNumbers.map((e) {
                    return Tab(text: '$e');
                  }).toList(),
                  onTap: (index) {
                    VerticalScrollableTabBarStatus.setIndex(index);
                  },
                ),
              ),
            ],
          ),
        );
      case 2:
        List<String> miniNumbers = List.generate(30, (index) => 'item $index');
        return Scaffold(
          appBar: AppBar(title: Text(widget.name)),
          body: Column(
            children: [
              CustomTabBar(
                tabScrollController: _tabScrollController,
                bodyScrollController: _bodyScrollController,
                tabs: miniNumbers.map((e) => Text('$e')).toList(),
              ),
              Expanded(
                child: CustomTabView(
                  tabScrollController: _tabScrollController,
                  bodyScrollController: _bodyScrollController,
                  children: miniNumbers
                      .asMap()
                      .entries
                      .map((e) => renderContainer(
                          color: rainbowColors[e.key % rainbowColors.length], index: e.key))
                      .toList(),
                  customScrollMode: CustomScrollMode.fix,
                ),
              ),
            ],
          ),
        );
      default:
        throw Exception('No defined index');
    }
  }
}
