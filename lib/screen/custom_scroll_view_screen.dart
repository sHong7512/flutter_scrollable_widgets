import 'package:flutter/material.dart';
import 'package:scrollable_widgets/const/colors.dart';

import '../const/enviroment.dart';

class _SliverFixedHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;
  final double maxHeight;
  final double minHeight;

  _SliverFixedHeaderDelegate({
    required this.child,
    required this.maxHeight,
    required this.minHeight,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(
      child: child,
    );
  }

  @override
  double get maxExtent => maxHeight;

  @override
  double get minExtent => minHeight;

  @override
  // oldDelegate => build가 실행이 됬을 때 이전 Delegate
  // shouldRebuild => 새로 빌드를 실행할지 말지 결정해주는 함수
  // covariant => 상속된 클래스도 사용가능
  // bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
  bool shouldRebuild(_SliverFixedHeaderDelegate oldDelegate) {
    return oldDelegate.minHeight != minHeight ||
        oldDelegate.maxHeight != maxHeight ||
        oldDelegate.child != child;
  }
}

class CustomScrollViewScreen extends StatelessWidget {

  CustomScrollViewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          renderSliverAppbar(),
          renderHeader(),
          renderBuilderSliverList(),
          renderHeader(),
          renderBuilderSliverGrid(),
          renderHeader(),
          renderChildSliverList(),
        ],
      ),
    );
  }

  // AppBar
  SliverAppBar renderSliverAppbar() {
    return SliverAppBar(
      //스크롤 했을 때 리스트의 중간에도 AppBar가 내려오게 할 수 있음.
      floating: false,
      //앱바 고정
      pinned: false,
      //자석 효과 , floating이 true에만 사용 가능
      snap: false,
      //맨 위에서 한개 이상으로 스크롤 했을 때, 앱바가 리스트 따라서 늘리기 가능
      stretch: true,
      expandedHeight: 200,
      collapsedHeight: 120,
      flexibleSpace: FlexibleSpaceBar(
        background: Image.asset(
          'asset/image/image_1.jpeg',
          fit: BoxFit.cover,
        ),
        title: Text('FlexibleSpace'),
      ),
      title: Text('CustomScrollViewScreen'),
    );
  }

  //SliverPersistantHeader
  SliverPersistentHeader renderHeader() {
    return SliverPersistentHeader(
      pinned: true, //헤더가 쌓임
      delegate: _SliverFixedHeaderDelegate(
        child: Container(
          color: Colors.black,
          child: Center(
            child: Text(
              '슬리버 퍼시스턴트 헤더',
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
        numbers
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
        childCount: 30, // ListView 의 itemCount와 같음
      ),
    );
  }

  // 3
  // GridView.count 유사함
  SliverGrid renderChildSliverGrid() {
    return SliverGrid(
      delegate: SliverChildListDelegate(
        numbers
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
        childCount: 50,
      ),
      gridDelegate:
          SliverGridDelegateWithMaxCrossAxisExtent(maxCrossAxisExtent: 150),
    );
  }
}
