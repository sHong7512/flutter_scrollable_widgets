import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:scrollable_widgets/const/environment.dart';

import '../../const/colors.dart';

class TabBarScreen extends StatefulWidget {
  const TabBarScreen({Key? key}) : super(key: key);

  @override
  State<TabBarScreen> createState() => _TabBarScreenState();
}

class _TabBarScreenState extends State<TabBarScreen> with SingleTickerProviderStateMixin {
  late TabController tabController = TabController(length: miniNumbers.length, vsync: this);

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TabBarView Screen'),
        bottom: TabBar(
          controller: tabController,
          isScrollable: true,
          onTap: (page) => log('$page'),
          tabs: miniNumbers.map((e) => Tab(text: '$e')).toList(),
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: miniNumbers
            .map((e) => renderContainer(color: rainbowColors[e % rainbowColors.length], index: e))
            .toList(),
      ),
    );
  }
}
