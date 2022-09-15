

import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';

import 'colors.dart';

class PostDesign extends StatefulWidget {
  final Map data;
  const PostDesign({super.key, required this.data});

  @override
  State<PostDesign> createState() => _PostDesignState();
}

class _PostDesignState extends State<PostDesign> {
  @override
  Widget build(BuildContext context) {
    final double widthScreen = MediaQuery.of(context).size.width;

    return Container(
        ///////
        decoration: BoxDecoration(color: mobileBackgroundColor,
        borderRadius: BorderRadius.circular(12)

        ),
        
        margin: widthScreen>600 ? EdgeInsets.symmetric(vertical: 55, horizontal: widthScreen / 6) : null,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 13.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children:  [
                      Container(
                        padding: const EdgeInsets.all(3),
                        decoration: const BoxDecoration(shape: BoxShape.circle,
                        color: Color.fromARGB(125, 78, 91, 110)),
                        child:  CircleAvatar(
                          radius: 33,
                          backgroundImage: NetworkImage(
                              widget.data["profileImg"]),
                        ),
                      ),
                      const SizedBox(
                        width: 17,
                      ),
                       Text(
                        widget.data["username"],
                        style: TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                  IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert))
                ],
              ),
            ),
            Image.network(widget.data["imgPost"],
            fit: BoxFit.cover,
            height: MediaQuery.of(context).size.height * 0.50,
            width: double.infinity,),
      
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 14.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      IconButton(onPressed: (){}, icon: const Icon(Icons.favorite_border)),
                      IconButton(onPressed: (){}, icon: const Icon(Icons.comment_outlined)),
                      IconButton(onPressed: (){}, icon: const Icon(Icons.send)),
                    ],
                  ),
                      IconButton(onPressed: (){}, icon: const Icon(Icons.bookmark_outline)),
            
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(10, 0, 0, 10),
              width: double.infinity,
              child:  Text(" ${ widget.data["likes"].length}  ${ widget.data["likes"].length > 1? "Likes" : "Like" } ",
              style: TextStyle(fontSize: 18, color: Color.fromARGB(137, 255, 255, 255)),),
            ),
      
            Row(
              children:   [
                SizedBox(width: 9,),
                 Text( widget.data["username"  ],
                 textAlign: TextAlign.start,
                style: TextStyle(fontSize: 20, color: Colors.white),),
                SizedBox(width: 12,),
                Text(widget.data["description"],
                 textAlign: TextAlign.start,
      
                style: TextStyle(fontSize: 18, color: Colors.white),)
              ],
            ),
      
            GestureDetector(
              onTap: () {
                
              },
              child: Container(
                margin: const EdgeInsets.fromLTRB(10, 9, 9, 10),
                width: double.infinity,
            
                child: Text("view all 100 comments", style: TextStyle(fontSize: 16, color: Color.fromARGB(137, 255, 255, 255)),),),
            ),
      
            Container(
                margin: const EdgeInsets.fromLTRB(10, 0, 9, 10),
                width: double.infinity,
            
                child: Text(
                DateFormat("MMMM d," "y").format( widget.data["datePublished"].toDate()),
                 style: TextStyle(fontSize: 16, color: Color.fromARGB(137, 255, 255, 255)),),),
      
          ],
        ),
      );
  }
}