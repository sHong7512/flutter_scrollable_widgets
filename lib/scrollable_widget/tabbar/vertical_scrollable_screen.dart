import 'package:flutter/material.dart';
import 'package:scrollable_widgets/const/environment.dart';
import 'package:vertical_scrollable_tabview/vertical_scrollable_tabview.dart';

import '../../const/colors.dart';

/// vertical_scrollable_tabview: ^0.0.7
class VerticalScrollableScreen extends StatefulWidget {
  const VerticalScrollableScreen({Key? key}) : super(key: key);

  @override
  State<VerticalScrollableScreen> createState() => _VerticalScrollableScreenState();
}

class _VerticalScrollableScreenState extends State<VerticalScrollableScreen> with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: miniNumbers.length, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: VerticalScrollableTabView(
        tabController: tabController,
        listItemData: miniNumbers,
        verticalScrollPosition: VerticalScrollPosition.end,
        eachItemChild: (object, index) => renderContainer(color: rainbowColors[index % rainbowColors.length], index: index),
        slivers: [
          SliverAppBar(
            title: Text("SliverAppBar"),
            pinned: true,
            bottom: TabBar(
              isScrollable: true,
              controller: tabController,
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
  }
}