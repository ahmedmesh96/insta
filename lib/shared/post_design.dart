import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:insta/firbase_services/firestore.dart';
import 'package:insta/screens/comments.dart';
import 'package:intl/intl.dart';
import 'colors.dart';
import 'heart_animation.dart';

class PostDesign extends StatefulWidget {
  final Map data;
  const PostDesign({super.key, required this.data});

  @override
  State<PostDesign> createState() => _PostDesignState();
}

class _PostDesignState extends State<PostDesign> {
  int commentCount = 0;
  bool showHeart = false;
  bool isLikeAnimating = false;
  bool isShowText = true;
  

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
                      padding: const EdgeInsets.all(20),
                      child: const Text(
                        "Delete Post",
                        style: TextStyle(fontSize: 18),
                      ),
                    )
                  : const SimpleDialogOption(
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
                padding: const EdgeInsets.all(20),
                child: const Text(
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
          ? const EdgeInsets.symmetric(
              // vertical: 55, horizontal: widthScreen / 6
              )
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
                        radius: widthScreen > 600
                            ? widthScreen * 0.06
                            : widthScreen * 0.07,
                        backgroundImage:
                            NetworkImage(widget.data["profileImg"]),
                      ),
                    ),
                    const SizedBox(
                      width: 17,
                    ),
                    SizedBox(
                      width: widthScreen > 600
                          ? widthScreen * 0.1
                          : widthScreen * 0.12,
                      child: FittedBox(
                        child: Text(
                          widget.data["username"],
                          // style: const TextStyle(fontSize: 15),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: widthScreen > 600
                      ? widthScreen * 0.08
                      : widthScreen * 0.12,
                  child: FittedBox(
                    child: IconButton(
                        onPressed: () {
                          showmodel();
                        },
                        icon: const Icon(Icons.more_vert)),
                  ),
                )
              ],
            ),
          ),

          widthScreen > 600 ? 
          InkWell(
            onTap: () {
              setState(() {
                isShowText = ! isShowText;
              });
            },
            child: Container(
              width: widthScreen,
              margin: EdgeInsets.all(widthScreen > 600? widthScreen * 0.01 : widthScreen* 0.02),
              child: Text(
                
                widget.data["description"],
                overflow: TextOverflow.ellipsis,
                maxLines: isShowText? null: 10,
                
                
                
                style: const TextStyle( color: Colors.white, fontWeight: FontWeight.w200, fontSize: 35), 
              ),
            ),
          )
          :
          InkWell(
            onTap: () {
              setState(() {
                isShowText = !isShowText;
              });
            },
            child: Container(
              width: widthScreen,
              margin: EdgeInsets.all(widthScreen > 600? widthScreen * 0.01 : widthScreen* 0.02),
              child: Text(
                
                widget.data["description"],
                overflow: TextOverflow.ellipsis,
                maxLines: isShowText ? null : 10,
                
                
                
                style: const TextStyle( color: Colors.white, fontWeight: FontWeight.w200, fontSize: 20), 
              ),
            ),
          ),
          GestureDetector(
            onDoubleTap: () async {
              setState(() {
                isLikeAnimating = true;
              });

              // after 3 secound remove heart

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
                              child: const Center(
                                child: CircularProgressIndicator(),
                              ),
                            );
                    },
                  ),
                ),
                AnimatedOpacity(
                  duration: const Duration(milliseconds: 200),
                  opacity: isLikeAnimating ? 1 : 0,
                  child: LikeAnimation(
                    isAnimating: isLikeAnimating,
                    duration: const Duration(
                      milliseconds: 400,
                    ),
                    onEnd: () {
                      setState(() {
                        isLikeAnimating = false;
                      });
                    },
                    child: const Icon(
                      Icons.favorite,
                      color: Colors.white,
                      size: 111,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 14.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: widthScreen * 0.3,
                  child: FittedBox(
                    child: Row(
                      children: [
                        LikeAnimation(
                          isAnimating: widget.data['likes']
                              .contains(FirebaseAuth.instance.currentUser!.uid),
                          smallLike: true,
                          child: IconButton(
                            onPressed: () async {
                              try {
                                await FireStoreMethods()
                                    .toggleLikes(postData: widget.data);
                              } catch (e) {
                                print(e.toString());
                              }
                            },
                            icon: widget.data['likes'].contains(
                                    FirebaseAuth.instance.currentUser!.uid)
                                ? const Icon(
                                    Icons.favorite,
                                    color: Colors.red,
                                  )
                                : const Icon(
                                    Icons.favorite_border,
                                  ),
                          ),
                        ),
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
                        IconButton(
                            onPressed: () {}, icon: const Icon(Icons.send)),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: widthScreen * 0.1,
                  child: FittedBox(
                    child: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.bookmark_outline)),
                  ),
                ),
              ],
            ),
          ),
          Stack(
            children: [
              Container(),
              Container(
                margin: const EdgeInsets.fromLTRB(10, 0, 0, 10),
                // width: double.infinity,
                width:
                    widthScreen > 600 ? widthScreen * 0.09 : widthScreen * 0.13,

                child: FittedBox(
                  child: Text(
                    " ${widget.data["likes"].length}  ${widget.data["likes"].length > 1 ? "Likes" : "Like"} ",
                    style: const TextStyle(
                        fontSize: 18,
                        color: Color.fromARGB(137, 255, 255, 255)),
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              const SizedBox(
                width: 9,
              ),
              SizedBox(
                width:
                    widthScreen > 600 ? widthScreen * 0.09 : widthScreen * 0.11,
                child: FittedBox(
                  child: Text(
                    widget.data["username"],
                    textAlign: TextAlign.start,
                    style: const TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(
                width: 12,
              ),
              SizedBox(
                width:
                    widthScreen > 600 ? widthScreen * 0.06 : widthScreen * 0.08,
                child: FittedBox(
                  child: Text(
                    widget.data["description"],
                    textAlign: TextAlign.start,
                    style: const TextStyle( color: Colors.white, fontWeight: FontWeight.w200),
                  ),
                ),
              ),
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
            child: Stack(
              alignment: Alignment.centerLeft,
              children: [
                Container(
                  
                  width: double.infinity,
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(10, 9, 9, 10),

                  width: widthScreen > 600
                      ? widthScreen * 0.23
                      : widthScreen * 0.333,
                  child: FittedBox(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "view all ${commentCount} comments",
                      style: const TextStyle(
                          color: Color.fromARGB(137, 255, 255, 255)),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Stack(
            children: [
              Container(),
              Container(
            margin: const EdgeInsets.fromLTRB(10, 0, 0, 10),
            width: widthScreen > 600
                      ? widthScreen * 0.23
                      : widthScreen * 0.333,
            child: FittedBox(
              child: Text(
                DateFormat("MMMM d," "y")
                    .format(widget.data["datePublished"].toDate()),
                style: const TextStyle(
                    fontSize: 16, color: Color.fromARGB(137, 255, 255, 255)),
              ),
            ),
          ),

            ],
          ),
          
        ],
      ),
    );
  }
}
