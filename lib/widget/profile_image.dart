import 'package:flutter/material.dart';

class ProfiePhotoWidget extends StatefulWidget {
  
 
  const ProfiePhotoWidget({
    super.key, 
  });

  @override
  State<ProfiePhotoWidget> createState() => _ProfiePhotoWidgetState();
}

class _ProfiePhotoWidgetState extends State<ProfiePhotoWidget> {
  Map userData = {};
  @override
  Widget build(BuildContext context) {
    final double profileHeight = MediaQuery.of(context).size.width;
    

    
    return Stack(
      children: [
        CircleAvatar(
          radius: profileHeight / 7.8,
          backgroundColor: Colors.deepOrangeAccent,
          child: CircleAvatar(
            radius: profileHeight / 8,
            backgroundColor: Colors.grey.shade800,
            backgroundImage: const NetworkImage(
                "https://loveshayariimages.in/wp-content/uploads/2021/10/1080p-Latest-Whatsapp-Profile-Images-1.jpg"),
          ),
        ),
        Positioned(
          bottom: 0,
          right: -12,
          child: SizedBox(
            height: profileHeight / 13,
            child: FloatingActionButton(onPressed: () {},
            backgroundColor: Colors.deepOrange,
            
            child: Icon(Icons.add, size: 25, color: Color.fromARGB(255, 14, 15, 34),),
            ),
          ),
        ),
      ],
    );
  }
}
