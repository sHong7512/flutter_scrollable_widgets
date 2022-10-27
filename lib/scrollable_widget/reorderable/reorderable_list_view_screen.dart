import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

List<String> reorderableList = [
  '기본 전체 로딩되는 위젯',
  '~.builder 위젯',
];

class ReorderableListViewScreen extends StatefulWidget {
  ReorderableListViewScreen({Key? key}) : super(key: key);

  @override
  State<ReorderableListViewScreen> createState() => _ReorderableListViewScreenState();
}

class _ReorderableListViewScreenState extends State<ReorderableListViewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('ReorderableListViewScreen')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: reorderableList
            .asMap()
            .entries
            .map((entry) => ElevatedButton(
                onPressed: () {
                  GoRouter.of(context).push('/reorderable/${entry.key}');
                },
                child: Text(entry.value)))
            .toList(),
      ),
    );
  }
}
