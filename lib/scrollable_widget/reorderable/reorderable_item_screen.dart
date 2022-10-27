import 'package:flutter/material.dart';
import 'package:scrollable_widgets/const/colors.dart';
import 'package:scrollable_widgets/const/environment.dart';

class ReorderableItemScreen extends StatefulWidget {
  final int index;
  final String name;

  const ReorderableItemScreen({
    Key? key,
    required this.index,
    required this.name,
  }) : super(key: key);

  @override
  State<ReorderableItemScreen> createState() => _ReorderableItemScreenState();
}

class _ReorderableItemScreenState extends State<ReorderableItemScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: FittedBox(fit: BoxFit.fitWidth, child: Text(widget.name))),
      body: getWidget(widget.index),
    );
  }

  Widget getWidget(int index) {
    switch (index) {
      case 0:
        return ReorderableListView(
          onReorder: (int oldIndex, int newIndex) {
            setState(() {
              if (oldIndex < newIndex) {
                newIndex -= 1;
              }
              final item = numbers.removeAt(oldIndex);
              numbers.insert(newIndex, item);
            });
          },
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
        return ReorderableListView.builder(
          itemBuilder: (BuildContext context, int index) {
            return renderContainer(
              color: rainbowColors[numbers[index] % rainbowColors.length],
              index: numbers[index],
            );
          },
          itemCount: numbers.length,
          onReorder: (int oldIndex, int newIndex) {
            setState(() {
              if (oldIndex < newIndex) {
                newIndex -= 1;
              }
              final item = numbers.removeAt(oldIndex);
              numbers.insert(newIndex, item);
            });
          },
        );
      default:
        throw Exception('No defined index');
    }
  }
}
