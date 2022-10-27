import 'package:flutter/material.dart';
import 'package:scrollable_widgets/const/colors.dart';
import 'package:scrollable_widgets/const/environment.dart';

class GridViewItemScreen extends StatefulWidget {
  final int index;
  final String name;

  const GridViewItemScreen({
    Key? key,
    required this.index,
    required this.name,
  }) : super(key: key);

  @override
  State<GridViewItemScreen> createState() => _GridViewItemScreenState();
}

class _GridViewItemScreenState extends State<GridViewItemScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: FittedBox(fit: BoxFit.fitWidth, child: Text(widget.name))),
      body: getWidget(widget.index),
    );
  }

  late final axisController = TextEditingController()..text = '100';
  Widget getWidget(int index) {
    switch (index) {
      case 0:
        return GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 12.0,
          mainAxisSpacing: 12.0,
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
        return GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12.0,
            mainAxisSpacing: 12.0,
          ),
          itemCount: numbers.length,
          itemBuilder: (context, index) {
            return renderContainer(
              color: rainbowColors[index % rainbowColors.length],
              index: index,
            );
          },
        );
      case 2:
        return Column(
          children: [
            SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'maxCrossAxisExtent',
              ),
              controller: axisController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
            ),
            ElevatedButton(
                onPressed: () {
                  setState(() {});
                },
                child: Text('Change maxCrossAxisExtent!')),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent:
                      axisController.text.isNotEmpty ? double.parse(axisController.text) : 100,
                ),
                itemCount: numbers.length,
                itemBuilder: (context, index) {
                  return renderContainer(
                    color: rainbowColors[index % rainbowColors.length],
                    index: index,
                  );
                },
              ),
            ),
          ],
        );
      default:
        throw Exception('No defined index');
    }
  }
}