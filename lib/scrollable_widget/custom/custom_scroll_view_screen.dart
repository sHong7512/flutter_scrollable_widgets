import 'package:flutter/material.dart';
import 'package:scrollable_widgets/const/colors.dart';
import 'package:scrollable_widgets/const/environment.dart';

import 'sliver_fixed_header_delegate.dart';

class CustomScrollViewScreen extends StatelessWidget {
  List<String> customList = [
    'ListView 기본 생성자와 유사함',
    'ListView.builder 생성자와 유사함',
    'GridView.count 유사함',
    'GridView.builder 유사함',
  ];

  CustomScrollViewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            renderSliverAppbar(),
            renderHeader(customList[0]),
            renderChildSliverList(),
            renderHeader(customList[1]),
            renderBuilderSliverList(),
            renderHeader(customList[2]),
            renderChildSliverGrid(),
            renderHeader(customList[3]),
            renderBuilderSliverGrid(),
          ],
        ),
      ),
    );
  }

  // AppBar
  SliverAppBar renderSliverAppbar() {
    return SliverAppBar(
      //스크롤 했을 때 리스트의 중간에도 AppBar가 내려오게 할 수 있음.
      floating: false,
      //앱바 고정
      pinned: true,
      //자석 효과 , floating이 true에만 사용 가능
      snap: false,
      //맨 위에서 한개 이상으로 스크롤 했을 때, 앱바가 리스트 따라서 늘리기 가능
      stretch: true,
      expandedHeight: 250,
      // collapsedHeight: 100,
      flexibleSpace: FlexibleSpaceBar(
        background: Image.asset(
          'asset/image/image_1.jpeg',
          fit: BoxFit.cover,
        ),
        title: Text('FlexibleSpace'),
      ),
      // title: Text('CustomScrollViewScreen'),
    );
  }

  //SliverPersistentHeader
  SliverPersistentHeader renderHeader(String title) {
    return SliverPersistentHeader(
      pinned: true, //헤더가 쌓임
      delegate: SliverFixedHeaderDelegate(
        child: Container(
          color: Colors.black,
          child: Center(
            child: Text(
              title,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        minHeight: 50,
        maxHeight: 200,
      ),
    );
  }

  // 1
  // ListView 기본 생성자와 유사함
  SliverList renderChildSliverList() {
    return SliverList(
      delegate: SliverChildListDelegate(
        miniNumbers
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

  // 2
  // ListView.builder 생성자와 유사함
  SliverList renderBuilderSliverList() {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return renderContainer(
            color: rainbowColors[index % rainbowColors.length],
            index: index,
          );
        },
        childCount: miniNumbers.length, // ListView 의 itemCount와 같음
      ),
    );
  }

  // 3
  // GridView.count 유사함
  SliverGrid renderChildSliverGrid() {
    return SliverGrid(
      delegate: SliverChildListDelegate(
        miniNumbers
            .map(
              (e) => renderContainer(
                color: rainbowColors[e % rainbowColors.length],
                index: e,
              ),
            )
            .toList(),
      ),
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 5),
    );
  }

  // 4
  // GridView.builder 와 비슷함
  SliverGrid renderBuilderSliverGrid() {
    return SliverGrid(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return renderContainer(
            color: rainbowColors[index % rainbowColors.length],
            index: index,
          );
        },
        childCount: miniNumbers.length,
      ),
      gridDelegate:
          SliverGridDelegateWithMaxCrossAxisExtent(maxCrossAxisExtent: 150),
    );
  }
}
