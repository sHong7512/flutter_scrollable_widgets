import 'package:flutter/material.dart';
import 'package:scrollable_widgets/const/colors.dart';
import 'package:scrollable_widgets/const/environment.dart';

class ListViewItemScreen extends StatelessWidget {
  final int index;
  final String name;

  const ListViewItemScreen({
    Key? key,
    required this.index,
    required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: FittedBox(fit: BoxFit.fitWidth, child: Text(name))),
      body: getWidget(index),
    );
  }

  Widget getWidget(int index) {
    switch (index) {
      case 0:
        return ListView(
          children: numbers
              .map(
                (e) => renderContainer(
                  color: rainbowColors[e % rainbowColors.length],
                  index: e,
                ),
              )
              .toList(),
        );
      case 1:
        return ListView.builder(
          itemCount: numbers.length,
          itemBuilder: (context, index) {
            return renderContainer(
              color: rainbowColors[index % rainbowColors.length],
              index: index,
            );
          },
        );
      case 2:
        return ListView.separated(
          itemCount: numbers.length,
          itemBuilder: (context, index) {
            return renderContainer(
              color: rainbowColors[index % rainbowColors.length],
              index: index,
            );
          },
          separatorBuilder: (context, index) {
            // 3개의 아이템마다 배너 보여주기
            if (index % 3 == 2) {
              return renderContainer(
                color: Colors.black,
                index: 777,
                height: 100,
              );
            }
            return Container();
          },
        );
      default:
        throw Exception('No defined index');
    }
  }
}
