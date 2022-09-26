import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';



class CustomIconButton extends StatefulWidget {
  final String number;
  final String buttonName;
  final String iconPathSVG;
  const CustomIconButton({super.key, required this.number, required this.buttonName,  required this.iconPathSVG});

  @override
  State<CustomIconButton> createState() => _CustomIconButtonState();
}

class _CustomIconButtonState extends State<CustomIconButton> {
  @override
  Widget build(BuildContext context) {
  
    final double widthScreen = MediaQuery.of(context).size.width;

    return SizedBox(
      width: widthScreen >600 ? widthScreen * 0.13 : widthScreen * 0.2,
      child: FittedBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(widget.number),
            SvgPicture.asset(widget.iconPathSVG, height: widthScreen > 600 ? widthScreen * 0.03 : widthScreen * 0.2, color: Colors.white,),
            Text(widget.buttonName)
          ],
        ),
      ),
    );
  }
}