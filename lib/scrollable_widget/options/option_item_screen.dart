import 'package:flutter/material.dart';
import 'package:scrollable_widgets/const/colors.dart';
import 'package:scrollable_widgets/const/environment.dart';

class OptionItemScreen extends StatelessWidget {
  final int index;
  final String name;

  const OptionItemScreen({
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
        return RefreshIndicator(
          onRefresh: () async {
            await Future.delayed(const Duration(seconds: 2));
            print('< ${this.runtimeType}> Update Complete!');
          },
          child: ListView(
            children: numbers
                .map((e) =>
                    renderContainer(color: rainbowColors[e % rainbowColors.length], index: e))
                .toList(),
          ),
        );
      case 1:
        return Scrollbar(
          thumbVisibility: true,
          child: SingleChildScrollView(
            child: Column(
              children: miniNumbers
                  .map((e) =>
                      renderContainer(color: rainbowColors[e % rainbowColors.length], index: e))
                  .toList(),
            ),
          ),
        );
      default:
        throw Exception('No defined index');
    }
  }
}
