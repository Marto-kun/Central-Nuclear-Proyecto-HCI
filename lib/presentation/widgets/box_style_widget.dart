import 'package:flutter/material.dart';

class BoxStyleWidget extends StatelessWidget {

  final Size size;
  final double width;
  final double height;
  final double borderRadiusValue;
  final double borderValue;
  final Color colorBorder;
  final Widget widget;
  final Color colorContainer;

  const BoxStyleWidget({
    super.key, 
    required this.size, 
    required this.width, 
    required this.height, 
    required this.borderRadiusValue, 
    required this.borderValue, 
    required this.colorBorder, 
    required this.widget, 
    required this.colorContainer
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width * width,
      height: size.height * height,
      decoration: BoxDecoration(
        color: colorContainer,
        border: Border.all(width: borderValue, color: colorBorder),
        borderRadius: BorderRadius.circular(borderRadiusValue),
      ),
      child: widget,
    );
  }
}