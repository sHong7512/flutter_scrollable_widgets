import 'package:flutter/material.dart';

import '../const/colors.dart';
import '../const/enviroment.dart';

class SingleChildItemScreen extends StatelessWidget {
  final int index;
  final String name;

  const SingleChildItemScreen({
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
        return SingleChildScrollView(
          child: Column(
            children: rainbowColors.map((e) => renderContainerSC(color: e)).toList(),
          ),
        );
      case 1:
        return SingleChildScrollView(
          // physics: NeverScrollableScrollPhysics(), // 스크롤 안됨
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              renderContainerSC(color: Colors.black),
            ],
          ),
        );
      case 2:
        return SingleChildScrollView(
          clipBehavior: Clip.none,
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              renderContainerSC(color: Colors.black),
            ],
          ),
        );
      case 3:
        return SingleChildScrollView(
          // physics: NeverScrollableScrollPhysics(), // 스크롤 안됨
          // physics: AlwaysScrollableScrollPhysics(), // 스크롤 됨
          // physics: BouncingScrollPhysics(), // ios 스타일
          // physics: ClampingScrollPhysics(), // android 스타일
          physics: ClampingScrollPhysics(), // android 스타일
          child: Column(
            children: rainbowColors.map((e) => renderContainerSC(color: e)).toList(),
          ),
        );
      case 4:
        return SingleChildScrollView(
          child: Column(
            children: numbers
                .map(
                  (e) => renderContainerSC(
                    color: rainbowColors[e % rainbowColors.length],
                    index: e,
                  ),
                )
                .toList(),
          ),
        );
      default:
        throw Exception('No defined index');
    }
  }
}
