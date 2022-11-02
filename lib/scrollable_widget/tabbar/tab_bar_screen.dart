import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

const List<String> tabBarList = [
  '기본 TabBar',
  'scroll + tab Library',
  'scroll + tab Custom',
];

class TabBarScreen extends StatelessWidget {
  const TabBarScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('SingleChildScrollView')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: tabBarList
            .asMap()
            .entries
            .map((entry) => ElevatedButton(
                onPressed: () {
                  GoRouter.of(context).push('/tabbar/${entry.key}');
                },
                child: Text(entry.value)))
            .toList(),
      ),
    );
  }
}
