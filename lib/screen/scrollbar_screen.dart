import 'package:flutter/material.dart';
import 'package:scrollable_widgets/const/colors.dart';
import 'package:scrollable_widgets/layout/main_layout.dart';

import '../const/enviroment.dart';

class ScrollbarScreen extends StatelessWidget {
  ScrollbarScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: 'ScrollbarScreen',
      body: Scrollbar(
        thumbVisibility: true,
        child: SingleChildScrollView(
          child: Column(
            children: numbers
                .map((e) => renderContainer(color: rainbowColors[e % rainbowColors.length], index: e))
                .toList(),
          ),
        ),
      ),
    );
  }
}
