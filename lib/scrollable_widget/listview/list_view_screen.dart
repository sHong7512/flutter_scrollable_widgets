import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

List<String> listViewList = [
  '기본, 모두 한번에 그림',
  '보이는 것만 그림',
  '2번 + 중간중간에 추가할 위젯',
];

class ListViewScreen extends StatelessWidget {
  ListViewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('ListViewScreen')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: listViewList
            .asMap()
            .entries
            .map((entry) => ElevatedButton(
                onPressed: () {
                  GoRouter.of(context).push('/list/${entry.key}');
                },
                child: Text(entry.value)))
            .toList(),
      ),
    );
  }
}
