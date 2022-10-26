import 'dart:developer';

import 'package:flutter/material.dart';

final List<int> numbers = List.generate(100, (index) => index);

Widget renderContainerSC({
  required Color color,
  int? index,
}) {
  if (index != null) {
    log('$index');
  }

  return Container(
    height: 300,
    color: color,
  );
}

Widget renderContainer({
  required Color color,
  required int index,
  double? height,
}) {
  if (index != null) {
    print(index);
  }

  return Container(
    height: height ?? 300,
    color: color,
    child: Center(
      child: Text(
        index.toString(),
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w700,
          fontSize: 30,
        ),
      ),
    ),
  );
}
