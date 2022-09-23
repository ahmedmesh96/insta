import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:insta/firbase_services/firestore.dart';
import 'package:insta/screens/comments.dart';
import 'package:intl/intl.dart';

import 'colors.dart';

class PostDesign extends StatefulWidget {
  final Map data;
  const PostDesign({super.key, required this.data});

  @override
  State<PostDesign> createState() => _PostDesignState();
}

class _PostDesignState extends State<PostDesign> {
  int commentCount = 0;
  bool showHeart = false;

  getCommentCount() async {
    try {
      QuerySnapshot commentdata = await FirebaseFirestore.instance
          .collection("postSSS")
          .doc(widget.data["postId"])
          .collection("commentSSS")
          .get();

      setState(() {
        commentCount = commentdata.docs.length;
      });
    } catch (e) {
      print(e.toString());
    }
  }

  showmodel() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            children: [
              FirebaseAuth.instance.currentUser!.uid == widget.data["uid"]
                  ? SimpleDialogOption(
                      onPressed: () async {
                        Navigator.of(context).pop();

                        await FirebaseFirestore.instance
                            .collection("postSSS")
                            .doc(widget.data["postId"])
                            .delete();
                      },
                      padding: EdgeInsets.all(20),
                      child: Text(
                        "Delete Post",
                        style: TextStyle(fontSize: 18),
                      ),
                    )
                  : SimpleDialogOption(
                      padding: EdgeInsets.all(20),
                      child: Text(
                        "You can't Delete Post",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
              SimpleDialogOption(
                onPressed: () async {
                  Navigator.of(context).pop();
                },
                padding: EdgeInsets.all(20),
                child: Text(
                  "Cancel",
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          );
        });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCommentCount();
  }

  @override
  Widget build(BuildContext context) {
    final double widthScreen = MediaQuery.of(context).size.width;

    return Container(
      ///////
      decoration: BoxDecoration(
          color: mobileBackgroundColor,
          borderRadius: BorderRadius.circular(12)),

      margin: widthScreen > 600
          ? EdgeInsets.symmetric(vertical: 55, horizontal: widthScreen / 6)
          : null,
      child: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 16.0, horizontal: 13.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(3),
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color.fromARGB(125, 78, 91, 110)),
                      child: CircleAvatar(
                        radius: 33,
                        backgroundImage:
                            NetworkImage(widget.data["profileImg"]),
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
                IconButton(
                    onPressed: () {
                      showmodel();
                    },
                    icon: const Icon(Icons.more_vert))
              ],
            ),
          ),
          GestureDetector(
            onDoubleTap: () async {
              setState(() {
                showHeart = true;
              });

              // after 3 secound remove heart
              Timer(Duration(seconds: 1), () {
                setState(() {
                showHeart = false;
                  
                });
              });

              try {
                await FireStoreMethods().toggleLikes(postData: widget.data);
              } catch (e) {
                print(e.toString());
              }
            },
            child: Stack(
              alignment: Alignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(9),
                  child: Image.network(
                    widget.data["imgPost"],
                    fit: BoxFit.cover,
                    height: MediaQuery.of(context).size.height * 0.50,
                    width: double.infinity,
                    loadingBuilder: (context, child, progress) {
                      return progress == null
                          ? child
                          : SizedBox(
                              height: MediaQuery.of(context).size.height * 0.50,
                              child:
                                  Center(child: CircularProgressIndicator()));
                    },
                  ),
                ),
                showHeart
                    ? Icon(
                        Icons.favorite,
                        color: Colors.white,
                        size: 200,
                      )
                    : 
                    SizedBox(height: 1,),
                    // Icon(
                    //     Icons.favorite,
                    //     color: Colors.red,
                    //     size: 200,
                    //   )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 14.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    IconButton(
                        onPressed: () async {
                          // dddddddddddd

                          try {
                            await FireStoreMethods()
                                .toggleLikes(postData: widget.data);
                          } catch (e) {
                            print(e.toString());
                          }
                        },
                        icon: widget.data["likes"].contains(
                                FirebaseAuth.instance.currentUser!.uid)
                            ? const Icon(
                                Icons.favorite,
                                color: Colors.red,
                              )
                            : const Icon(
                                Icons.favorite_border,
                              )),
                    IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CommentsScreen(
                                  data: widget.data,
                                  showTextField: true,
                                ),
                              ));
                        },
                        icon: const Icon(Icons.comment_outlined)),
                    IconButton(onPressed: () {}, icon: const Icon(Icons.send)),
                  ],
                ),
                IconButton(
                    onPressed: () {}, icon: const Icon(Icons.bookmark_outline)),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(10, 0, 0, 10),
            width: double.infinity,
            child: Text(
              " ${widget.data["likes"].length}  ${widget.data["likes"].length > 1 ? "Likes" : "Like"} ",
              style: TextStyle(
                  fontSize: 18, color: Color.fromARGB(137, 255, 255, 255)),
            ),
          ),
          Row(
            children: [
              SizedBox(
                width: 9,
              ),
              Text(
                widget.data["username"],
                textAlign: TextAlign.start,
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
              SizedBox(
                width: 12,
              ),
              Text(
                widget.data["description"],
                textAlign: TextAlign.start,
                style: TextStyle(fontSize: 18, color: Colors.white),
              )
            ],
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CommentsScreen(
                      data: widget.data,
                      showTextField: false,
                    ),
                  ));
            },
            child: Container(
              margin: const EdgeInsets.fromLTRB(10, 9, 9, 10),
              width: double.infinity,
              child: Text(
                "view all ${commentCount} comments",
                style: TextStyle(
                    fontSize: 16, color: Color.fromARGB(137, 255, 255, 255)),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(10, 0, 9, 10),
            width: double.infinity,
            child: Text(
              DateFormat("MMMM d," "y")
                  .format(widget.data["datePublished"].toDate()),
              style: TextStyle(
                  fontSize: 16, color: Color.fromARGB(137, 255, 255, 255)),
            ),
          ),
        ],
      ),
    );
  }
}
