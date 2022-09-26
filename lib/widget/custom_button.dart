import 'package:flutter/material.dart';


class CustomImageButton extends StatefulWidget {
  final String imagePath;
  final String upImageText;
  final String downImageText;

  final Function() onTap;
  
  
  const CustomImageButton({super.key, required this.imagePath, required this.upImageText, required this.downImageText, required this.onTap});

  @override
  State<CustomImageButton> createState() => _CustomImageButtonState();
}

class _CustomImageButtonState extends State<CustomImageButton> {
  @override
  Widget build(BuildContext context) {
    
    return InkWell(
      onTap: widget.onTap,
      child: Column(
        children: [
          Text(widget.upImageText, style: TextStyle(color: Colors.white, )),
         
          Image.asset(widget.imagePath, scale: 1.3,),
          Text(widget.downImageText, style: TextStyle(color: Colors.white, ),)
        ],
      ),
      
    );
  }
}