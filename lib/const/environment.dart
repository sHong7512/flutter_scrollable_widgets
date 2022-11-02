import 'dart:developer';

import 'package:flutter/material.dart';

final List<int> numbers = List.generate(100, (index) => index);

final List<int> miniNumbers = List.generate(20, (index) => index);

Widget renderContainer({
  required Color color,
  required int index,
  double? height,
}) {
  log('loaded index :: $index');
  return Container(
    key: Key('$index'),
    height: height ?? 100 *(1 + (index / 5)),
    color: color,
    child: Center(
      child: Text(
        index.toString(),
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w700,
          fontSize: 30,
        ),
      ),
    ),
  );
}
