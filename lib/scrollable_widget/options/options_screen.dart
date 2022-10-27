import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// SingleChildScrollView 는 모든 아이템을 전부 메모리에 랜더링한다. (ListView랑은 반대)
const List<String> optionList = [
  '스크롤 바',
  '스크롤 리프레쉬',
];

class OptionsScreen extends StatelessWidget {
  OptionsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Scroll Options')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: optionList
            .asMap()
            .entries
            .map((entry) => ElevatedButton(
                onPressed: () {
                  GoRouter.of(context).push('/options/${entry.key}');
                },
                child: Text(entry.value)))
            .toList(),
      ),
    );
  }
}
