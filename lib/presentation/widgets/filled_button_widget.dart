import 'package:flutter/material.dart';

class FilledButtonWidget extends StatelessWidget {

  final double width;
  final double height;
  final Function onPressed;
  final double borderRadiusValue;
  final Color colorButton;
  final String textButton;
  final IconData iconButton;
  final Color colorText;
  final Color colorIcon;

  const FilledButtonWidget({
    super.key, 
    required this.width, 
    required this.height, 
    required this.onPressed, 
    required this.borderRadiusValue, 
    required this.colorButton, 
    required this.textButton, 
    required this.iconButton, 
    required this.colorText, 
    required this.colorIcon
  });

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;

    return SizedBox(
      width: size.width * width,
      height: size.height * height,
      child: FilledButton.icon(
        onPressed: () => onPressed(), 
        style: FilledButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(borderRadiusValue),
          ),
          backgroundColor: colorButton
        ),
        icon: Icon(iconButton, color: colorIcon,),
        label: Text(
          textButton, 
          style: textTheme.bodySmall?.copyWith(
            color: colorText, 
            fontWeight: FontWeight.bold
          ),
        ),
      ),
    );
  }
}