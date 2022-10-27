import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// SingleChildScrollView 는 모든 아이템을 전부 메모리에 랜더링한다. (ListView랑은 반대)
const List<String> singleChildList = [
  '기본 랜더링',
  '화면을 넘어가지 않아도 스크롤 되게하기',
  '위젯이 잘리지 않게 스크롤 되게하기',
  '여러가지 physics 정리',
  'SingleChildView 퍼포먼스',
];

class SingleChildScrollViewScreen extends StatelessWidget {
  SingleChildScrollViewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('SingleChildScrollView')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: singleChildList
            .asMap()
            .entries
            .map((entry) => ElevatedButton(
                onPressed: () {
                  GoRouter.of(context).push('/singlechild/${entry.key}');
                },
                child: Text(entry.value)))
            .toList(),
      ),
    );
  }
}
