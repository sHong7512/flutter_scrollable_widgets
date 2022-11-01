import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

List<String> pageViewList = [
  '기본, 모두 한번에 그림',
  '보이는 것만 그림',
  '넘김 보정 끔, 수직 페이징',
  'Controller 추가'
];

class PageViewScreen extends StatelessWidget {
  const PageViewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('PageView')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: pageViewList
            .asMap()
            .entries
            .map((entry) => ElevatedButton(
                onPressed: () {
                  GoRouter.of(context).push('/page/${entry.key}');
                },
                child: Text(entry.value)))
            .toList(),
      ),
    );
  }
}
