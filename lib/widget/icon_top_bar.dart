import 'package:flutter/material.dart';


class IconTopBar extends StatelessWidget {
  
  final IconData icon;
  final bool selected;
  final Function() onPressed;

  const IconTopBar({super.key,  
    required this.icon,
    required this.onPressed,
   
    required this.selected
  });


  @override
  Widget build(BuildContext context) {
    final double widthScreen = MediaQuery.of(context).size.width;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(onPressed: onPressed,
         icon: Icon(icon,  color: selected ? Colors.deepOrangeAccent : Colors.white,)
         ),
         

      ],
    );
  }
}