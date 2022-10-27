import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

List<String> gridViewList = ['한번에 다 그림', '보이는 것만 그림', '최대 사이즈 맞춰 빌드'];

/// GridView는 안드로이드 FlexBox랑 비슷
class GridViewScreen extends StatelessWidget {
  GridViewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('GridViewScreen')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: gridViewList
            .asMap()
            .entries
            .map((entry) => ElevatedButton(
                onPressed: () => GoRouter.of(context).push('/grid/${entry.key}'),
                child: Text(entry.value)))
            .toList(),
      ),
    );
  }
}
