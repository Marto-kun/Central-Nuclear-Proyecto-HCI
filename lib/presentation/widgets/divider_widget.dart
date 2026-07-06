import 'package:flutter/material.dart';

class DividerWidget extends StatelessWidget {

  final double start;
  final double end;
  final Color colorDivider;
  final double height;
  final double borderRadiusValue;

  const DividerWidget({
    super.key, 
    required this.start, 
    required this.end, 
    required this.height, 
    required this.colorDivider, 
    required this.borderRadiusValue, 
  });

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    
    return Divider(
      indent: size.width * start,
      endIndent: size.width * end,
      color: colorDivider,
      height: size.height * height,
    );
  }
}