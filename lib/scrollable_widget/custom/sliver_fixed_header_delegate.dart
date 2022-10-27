import 'package:flutter/material.dart';

class SliverFixedHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;
  final double maxHeight;
  final double minHeight;

  SliverFixedHeaderDelegate({
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
  bool shouldRebuild(SliverFixedHeaderDelegate oldDelegate) {
    return oldDelegate.minHeight != minHeight ||
        oldDelegate.maxHeight != maxHeight ||
        oldDelegate.child != child;
  }
}