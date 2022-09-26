import 'package:flutter/material.dart';

class CustomButtonScrollBar extends StatelessWidget {
  final Function() onTap;
  final String text;
  final bool selected;
  
  const CustomButtonScrollBar({super.key, required this.text, required this.onTap, required this.selected});

  @override
  Widget build(BuildContext context) {
    
  final double heightScreen = MediaQuery.of(context).size.height;
    final double widthScreen = MediaQuery.of(context).size.width;
    return widthScreen > 450 ?
    // ElevatedButton(
    //   style: ElevatedButton.styleFrom(
    //     shape: RoundedRectangleBorder(
    //       borderRadius: BorderRadius.circular(30)
    //     )
    //   ),
    //   onPressed: onTap, 
    //   child: Text(text, style: TextStyle( fontSize: 30),)
    //   )
    //   :
    //   ElevatedButton(
    //   style: ElevatedButton.styleFrom(
    //     shape: RoundedRectangleBorder(
    //       borderRadius: BorderRadius.circular(30)
    //     )
    //   ),
    //   onPressed: onTap, 
    //   child: Text(text, style: TextStyle( fontSize: 20),)
    //   )
    
    
    InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(4),
        padding: const EdgeInsets.only(top: 8, left: 13, bottom: 8, right: 13,),
        decoration: BoxDecoration(
          color: selected?  Colors.red : Colors.transparent,
          borderRadius: BorderRadius.circular(30)
    
        ),
        // height: heightScreen *0.04,
       
        child: Text(text, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25),),
    
      ),
    )

    :

    InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(4),
        padding: const EdgeInsets.only(top: 8, left: 13, bottom: 8, right: 13,),
        decoration: BoxDecoration(
          color: selected?  Colors.red : Colors.transparent,
          borderRadius: BorderRadius.circular(20)
    
        ),
        // height: heightScreen *0.04,
       
        child: Text(text, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),),
    
      ),
    )
    
    
    ;
  }
  
}