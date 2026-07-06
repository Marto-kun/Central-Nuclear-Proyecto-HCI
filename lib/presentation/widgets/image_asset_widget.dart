import 'package:flutter/material.dart';

class ImageAssetWidget extends StatelessWidget {

  final double width;
  final double height;
  final double borderRadiusValue;
  final String image;
  final double borderWidthValue;
  final Color colorBorder;

  const ImageAssetWidget({
    super.key, 
    required this.width, 
    required this.height, 
    required this.borderRadiusValue, 
    required this.image, 
    required this.borderWidthValue, 
    required this.colorBorder
  });

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Container(
      width: size.width * width,
      height: size.height * height,
      decoration: BoxDecoration(
        border: Border.all(width: borderWidthValue, color: colorBorder),
        borderRadius: BorderRadius.circular(borderRadiusValue)
      ),
      child: ClipRRect(
        borderRadius: BorderRadiusGeometry.circular(borderRadiusValue),
        child: Image.asset(
          image,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}