import 'dart:math';

import 'package:flutter/material.dart';
import 'package:scrollable_widgets/const/colors.dart';

import '../layout/main_layout.dart';

class SingleChildScrollViewScreen extends StatelessWidget {
  final List<int> numbers = List.generate(
    100,
    (index) => index,
  );

  SingleChildScrollViewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(numbers);

    return MainLayout(
      title: 'SingleChildeScrollView',
      body: renderPerformance(),
    );
  }

  // SingleChildScrollView 는 모든 아이템을 전부 메모리에 랜더링한다. (ListView랑은 반대)
  // 1
  // 기본 랜더링법
  Widget renderSimple() {
    return SingleChildScrollView(
      child: Column(
        children: rainbowColors.map((e) => renderContainer(color: e)).toList(),
      ),
    );
  }

  // 2
  // 화면을 넘어가지 않아도 스크롤 되게하기
  Widget renderAlwaysScroll() {
    return SingleChildScrollView(
      // physics: NeverScrollableScrollPhysics(), // 스크롤 안됨
      physics: AlwaysScrollableScrollPhysics(),
      child: Column(
        children: [
          renderContainer(color: Colors.black),
        ],
      ),
    );
  }

  // 3
  // 위젯이 잘리지 않게 스크롤 되게하기
  Widget renderClipScroll() {
    return SingleChildScrollView(
      clipBehavior: Clip.none,
      physics: AlwaysScrollableScrollPhysics(),
      child: Column(
        children: [
          renderContainer(color: Colors.black),
        ],
      ),
    );
  }

  // 4
  // 여러가지 physics 정리
  Widget renderPhysics() {
    return SingleChildScrollView(
      // physics: NeverScrollableScrollPhysics(), // 스크롤 안됨
      // physics: AlwaysScrollableScrollPhysics(), // 스크롤 됨
      // physics: BouncingScrollPhysics(), // ios 스타일
      // physics: ClampingScrollPhysics(), // android 스타일
      physics: ClampingScrollPhysics(), // android 스타일
      child: Column(
        children: rainbowColors.map((e) => renderContainer(color: e)).toList(),
      ),
    );
  }

  // 5
  // SingleChildView 퍼포먼스
  Widget renderPerformance() {
    return SingleChildScrollView(
      child: Column(
        children: numbers
            .map(
              (e) => renderContainer(
                color: rainbowColors[e % rainbowColors.length],
                index: e,
              ),
            )
            .toList(),
      ),
    );
  }

  Widget renderContainer({
    required Color color,
    int? index,
  }) {
    if (index != null) {
      print(index);
    }

    return Container(
      height: 300,
      color: color,
    );
  }

}
