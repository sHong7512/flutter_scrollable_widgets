import 'package:flutter/material.dart';

/**
 * * CustomTabBar, CustomTabView랑 연동 사용.
 * @author : sHong (ksh7512@uangel.com)
 */
class CustomTabCard extends StatefulWidget {
  CustomTabCard({required this.cardKey, required this.customTabModel}) : super(key: cardKey);
  final GlobalKey<CustomTabCardState> cardKey;
  final CustomTabModel customTabModel;

  @override
  State<CustomTabCard> createState() => CustomTabCardState();
}

class CustomTabCardState extends State<CustomTabCard> {
  bool _isSelected = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: _isSelected ? 1.0 : 0.5,
      duration: const Duration(milliseconds: 500),
      child: Container(
        color: _isSelected ? Colors.yellow : Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('${widget.customTabModel.label}', textAlign: TextAlign.center),
        ),
      ),
    );
  }

  setSelect(bool isSelected) {
    if (mounted) {
      setState(() {
        this._isSelected = isSelected;
      });
    }
  }
}

class CustomTabModel {
  CustomTabModel({required this.label});

  final String label;
}
