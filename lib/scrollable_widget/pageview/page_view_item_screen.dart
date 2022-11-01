import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../const/colors.dart';
import '../../const/environment.dart';

class PageViewItemScreen extends StatelessWidget {
  PageViewItemScreen({
    Key? key,
    required this.index,
    required this.name,
  }) : super(key: key);

  final int index;
  final String name;

  late PageController pageController = PageController(
    initialPage: 1,
  );

  late TextEditingController textEditingController = TextEditingController();

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
        return PageView(
          children: miniNumbers
              .map(
                (e) => renderContainer(
                  color: rainbowColors[e % rainbowColors.length],
                  index: e,
                ),
              )
              .toList(),
        );
      case 1:
        return PageView.builder(
          itemCount: miniNumbers.length,
          itemBuilder: (context, index) {
            return renderContainer(
                color: rainbowColors[index % rainbowColors.length], index: index);
          },
        );
      case 2:
        return PageView.builder(
          itemCount: miniNumbers.length,
          scrollDirection: Axis.vertical,
          pageSnapping: false,
          itemBuilder: (context, index) {
            return renderContainer(
                color: rainbowColors[index % rainbowColors.length], index: index);
          },
        );
      case 3:
        return Column(
          children: [
            const SizedBox(height: 16),
            TextField(
              controller: textEditingController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'page',
              ),
              keyboardType: TextInputType.number,
            ),
            ElevatedButton(
                onPressed: () {
                  try {
                    final page = int.parse(textEditingController.text);
                    // pageController.jumpToPage(page);
                    pageController.animateToPage(page,
                        duration: const Duration(milliseconds: 500), curve: Curves.linear);
                  } catch (e) {
                    log('이동할 수 없는 페이지 <${textEditingController.text}>:: $e');
                  }
                },
                child: Text('move Page')),
            Expanded(
              child: PageView.builder(
                itemCount: miniNumbers.length,
                controller: pageController,
                itemBuilder: (context, index) {
                  return renderContainer(
                      color: rainbowColors[index % rainbowColors.length], index: index);
                },
              ),
            )
          ],
        );
      default:
        throw Exception('No defined index');
    }
  }
}
