import 'dart:math';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:insta/icon/my_flutter_app_icons.dart';
import 'package:path/path.dart' show basename;
import '../bars/scroll_main_bar.dart';
import '../bars/top_bar.dart';
import '../shared/text_post_desgin.dart';
import 'add_post.dart';
import 'connection_screen.dart';





import '../shared/post_design.dart';





class MainHome extends StatefulWidget {
  final String uiddd;

  const MainHome({super.key, required this.uiddd});

  @override
  State<MainHome> createState() => _MainHomeState();
}

class _MainHomeState extends State<MainHome> {
  Map userData = {};
  bool isLoading = true;
  late int followers;
  late int following;
  late int postCount;
  late bool showFollow;
  late int connectionCount;

  final decController = TextEditingController();

  Uint8List? imgPath;
  String? imgName;

  getData() async {
    setState(() {
      isLoading = true;
    });
    // get Data from DB
    try {
      DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
          .instance
          .collection('userSSS')
          .doc(widget.uiddd)
          .get();

      userData = snapshot.data()!;

      followers = userData["followers"].length;
      following = userData["following"].length;
      connectionCount = followers + following;

      //
      showFollow = userData["followers"]
          .contains(FirebaseAuth.instance.currentUser!.uid);

      // to get post count
    //   var snapshotPosts = await FirebaseFirestore.instance
    //       .collection('postSSS')
    //       .where("uid", isEqualTo: widget.uiddd)
    //       .get();

    //   postCount = snapshotPosts.docs.length;
    // } catch (e) {
    //   print(e.toString());
    // }



    var snapshotTextPosts = await FirebaseFirestore.instance
          .collection('textPostSSS')
          .where("uid", isEqualTo: widget.uiddd)
          .get();

      postCount = snapshotTextPosts.docs.length;
    } catch (e) {
      print(e.toString());
    }





    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  showmodel() {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          children: [
            SimpleDialogOption(
              onPressed: () async {
                // Navigator.of(context).pop();
                await uploadImage2Screen(ImageSource.camera);
              },
              padding: const EdgeInsets.all(20),
              child: const Text(
                "From Camera",
                style: TextStyle(fontSize: 18),
              ),
            ),
            SimpleDialogOption(
              onPressed: () async {
                // Navigator.of(context).pop();
                await uploadImage2Screen(ImageSource.gallery);
              },
              padding: const EdgeInsets.all(20),
              child: const Text(
                "From Gallery",
                style: TextStyle(fontSize: 18),
              ),
            )
          ],
        );
      },
    );
  }

  uploadImage2Screen(ImageSource source) async {
    Navigator.pop(context);

    final pickedImg = await ImagePicker().pickImage(source: source);
    try {
      if (pickedImg != null) {
        imgPath = await pickedImg.readAsBytes();
        setState(() {
          // imgPath = File(pickedImg.path);
          imgName = basename(pickedImg.path);
          int random = Random().nextInt(9999999);
          imgName = "$random$imgName";
          print(imgName);
        });
      } else {
        print("NO img selected");
        // showSnackBar(context,"Error => $e");
      }
    } catch (e) {
      print("Error => $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final double widthScreen = MediaQuery.of(context).size.width;
    final double heightScreen = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        body: Container(
          height: heightScreen,
          width: widthScreen,
          decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
              Color.fromARGB(255, 38, 43, 116),
              Color.fromARGB(255, 14, 15, 34)
            ], begin: Alignment.topCenter),
          ),
          child: Column(
            children: [
              Stack(
                children: [
                  Container(),
                  SizedBox(
                      width: widthScreen > 600
                          ? widthScreen * 0.2
                          : widthScreen * 0.35,
                      child: FittedBox(child: TopIconsBar())),
                ],
              ),
              SizedBox(
                width:
                    widthScreen > 600 ? widthScreen * 0.2 : widthScreen * 0.35,
                child: FittedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Hello, ",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        " ${userData["username"]}",
                        style: const TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: heightScreen * 0.01,
              ),
              Stack(
                alignment: AlignmentDirectional.topCenter,
                children: [
                  Container(
                    height: heightScreen * 0.25,
                    width: widthScreen * 0.95,
                    decoration: BoxDecoration(
                      // color: Colors.white.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(25),
                      // border: Border.all(width: 2, color: Colors.white30)
                      gradient: LinearGradient(
                          colors: [
                            Color.fromARGB(255, 38, 43, 116),
                            Color.fromARGB(255, 14, 15, 34)
                          ],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          stops: [0.4, 1]),
                    ),
                  ),
                  Stack(
                    children: [],
                  ),
                  Column(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Stack(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(left: 10, top: 5),
                            padding: EdgeInsets.all(widthScreen > 600
                                ? widthScreen * 0.005
                                : widthScreen * 0.006),
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color.fromARGB(255, 232, 0, 0)),
                            child: CircleAvatar(
                              radius: widthScreen > 600
                                  ? widthScreen * 0.08
                                  : widthScreen * 0.1,
                              backgroundImage:
                                  NetworkImage(userData["profileImg"]),
                              // "https://www.indiewire.com/wp-content/uploads/2022/01/AP21190389554952-e1643225561835.jpg"),
                            ),
                          ),
                          Positioned(
                            bottom: 10,
                            right: 0,
                            child: SizedBox(
                              width: widthScreen > 600
                                  ? widthScreen * 0.04
                                  : widthScreen * 0.06,
                              child: FittedBox(
                                child: FloatingActionButton(
                                  onPressed: () {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => const AddPost(),
                                        ));
                                  },
                                  backgroundColor: Colors.deepOrange,
                                  child: SizedBox(
                                    width: widthScreen > 600
                                        ? widthScreen * 0.06
                                        : widthScreen * 0.13,
                                    child: const FittedBox(
                                      child: Icon(
                                        Icons.add,
                                        color:
                                            Color.fromARGB(255, 255, 255, 255),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                          margin: EdgeInsets.only(top: heightScreen * 0.005),
                          width: widthScreen * 0.4,
                          child: FittedBox(child: Text(userData["name"])))
                    ],
                  ),
                  Positioned(
                    bottom: 12,
                    left: 5,
                    right: 5,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        // connectins Button
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text("${connectionCount.toInt()}"),
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const ConnectionScreen(),
                                        ));
                                  });
                                },
                                icon: Icon(MyIcons.users_outline)),
                            Text("Connections")
                          ],
                        ),

                        // Favourte Button

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text("0"),
                            IconButton(
                                onPressed: () {},
                                icon: Icon(MyIcons.all_inclusive)),
                            Text("Favours")
                          ],
                        ),

                        //Tokens Button
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text("0"),
                            IconButton(
                                onPressed: () {}, icon: Icon(MyIcons.diamond)),
                            Text("Tokens")
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(
                height: heightScreen * 0.01,
              ),
              const ScrollMainBar(),
              SizedBox(
                height: heightScreen * 0.01,
              ),
              Expanded(
                child: Container(
                  // height: heightScreen ,
                  color: Colors.amber,
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('textPostSSS')
                        .orderBy("datePublished", descending: true)
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasError) {
                        return const Text('Something went wrong');
                      }

                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                            child: CircularProgressIndicator(
                          color: Colors.white,
                        ));
                      }

                      return ListView(
                          children: snapshot.data!.docs
                              .map((DocumentSnapshot document) {
                        Map<String, dynamic> data =
                            document.data()! as Map<String, dynamic>;
                        return TextPostDesgin(
                          data: data,
                        );
                      }).toList());
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
