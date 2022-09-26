import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:insta/firbase_services/firestore.dart';
import 'package:insta/shared/colors.dart';
import 'package:insta/shared/contants.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';


import '../provider/user_provider.dart';

class CommentsScreen extends StatefulWidget {
  final Map data;
  final bool showTextField;
  const CommentsScreen({super.key, required this.data, required this.showTextField});

  @override
  State<CommentsScreen> createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  final commentController = TextEditingController();

  @override
  void dispose() {
    commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<UserProvider>(context).getUser;

    return Scaffold(
      backgroundColor: mobileBackgroundColor,
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        title: const Text("Comments"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('postSSS')
                .doc(widget.data["postId"])
                .collection("commentSSS").orderBy("datePublished")
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return const Text('Something went wrong');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator(
                  color: Colors.white,
                );
              }

              return Expanded(
                child: ListView(
                  children:
                      snapshot.data!.docs.map((DocumentSnapshot document) {
                    Map<String, dynamic> data =
                        document.data()! as Map<String, dynamic>;
                    return Container(
                      margin: const  EdgeInsets.only(bottom: 14),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                margin: const  EdgeInsets.only(right: 12),
                                padding: const EdgeInsets.all(3),
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color.fromARGB(125, 78, 91, 110)),
                                child: CircleAvatar(
                                  backgroundImage: NetworkImage(
                                      data["profilePic"]
                                      // "https://childdevelopment.com.au/wp-content/uploads/what-is-child-development.jpg"
                                      ),
                                  radius: 26,
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        data["userName"]

                                        // "USERNAME"
                                        ,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17),
                                      ),
                                      const SizedBox(
                                        width: 11,
                                      ),
                                      Text(
                                        data["textComment"]
                                        // "nice pic"
                                        ,
                                        style: const TextStyle(fontSize: 16),
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    DateFormat('MMM d, ' 'y')
                                        .format(data["datePublished"].toDate())

                                    // "12/12/2012"

                                    ,
                                    style: const  TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400),
                                  )
                                ],
                              ),
                            ],
                          ),
                          IconButton(
                              onPressed: () {}, icon: const  Icon(Icons.favorite))
                        ],
                      ),
                    );
                  }).toList(),
                ),
              );
            },
          ),



          widget.showTextField  ?
          Container(
            margin: const  EdgeInsets.only(bottom: 12),
            child: Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 12),
                  padding: const EdgeInsets.all(3),
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color.fromARGB(125, 78, 91, 110)),
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(userData!.profileImg),
                    radius: 26,
                  ),
                ),
                Expanded(
                  child: TextField(
                    controller: commentController,
                    keyboardType: TextInputType.text,
                    obscureText: false,
                    decoration: decorationTextfield.copyWith(
                      hintText: "Comment as ${userData.username}",
                      suffixIcon: IconButton(
                          onPressed: () async {
                            await FireStoreMethods().uploadComment(
                                commentText: commentController.text,
                                postId: widget.data["postId"],
                                profileImg: userData.profileImg,
                                username: userData.username,
                                uid: userData.uid);

                            commentController.clear();
                          },
                          icon: const Icon(Icons.send)),
                    ),
                  ),
                )
              ],
            ),
          )
       : const SizedBox(height: 10,)
       
       
       
        ],
      ),
    );
  }
}
