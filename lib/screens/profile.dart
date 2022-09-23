import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:insta/shared/colors.dart';

class Profile extends StatefulWidget {
  final String uiddd;

  const Profile({super.key, required this.uiddd});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Map userData = {};
  bool isLoading = true;
  late int followers;
  late int following;
  late int postCount;
  late bool showFollow;

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

      //
      showFollow = userData["followers"]
          .contains(FirebaseAuth.instance.currentUser!.uid);

      // to get post count
      var snapshotPosts = await FirebaseFirestore.instance
          .collection('postSSS')
          .where("uid", isEqualTo: widget.uiddd)
          .get();

      postCount = snapshotPosts.docs.length;
    } catch (e) {
      print(e.toString());
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    final double widthScreen = MediaQuery.of(context).size.width;

    return isLoading
        ? Scaffold(
            backgroundColor: mobileBackgroundColor,
            body: Center(
                child: CircularProgressIndicator(
              color: Colors.white,
            )),
          )
        : Scaffold(
            backgroundColor:
                widthScreen > 600 ? webBackgroundColor : mobileBackgroundColor,
            appBar: AppBar(
                backgroundColor: mobileBackgroundColor,
                centerTitle: false,
                title: Text(userData["username"])),
            body: Container(
              decoration: BoxDecoration(
                  color: mobileBackgroundColor,
                  borderRadius: BorderRadius.circular(12)),
              margin: widthScreen > 600
                  ? EdgeInsets.symmetric(
                      vertical: 0, horizontal: widthScreen / 6)
                  : null,
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 10),
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color.fromARGB(125, 78, 91, 110)),
                        child: CircleAvatar(
                          radius: 40,
                          backgroundImage: NetworkImage(userData["profileImg"]),
                          // "https://www.indiewire.com/wp-content/uploads/2022/01/AP21190389554952-e1643225561835.jpg"),
                        ),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                Text(
                                  postCount.toString(),
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "Posts",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey),
                                )
                              ],
                            ),
                            SizedBox(
                              width: 17,
                            ),
                            Column(
                              children: [
                                Text(
                                  followers.toString(),
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "Followers",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey),
                                )
                              ],
                            ),
                            SizedBox(
                              width: 17,
                            ),
                            Column(
                              children: [
                                Text(
                                  following.toString(),
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "Following",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Container(
                      width: double.infinity,
                      // padding: EdgeInsets.only(left: 10),
                      margin: const EdgeInsets.fromLTRB(33, 21, 0, 0),
                      child: Text(userData["title"])),
                  SizedBox(
                    height: 15,
                  ),
                  Divider(
                    color: Colors.white,
                    thickness: widthScreen > 600 ? 0.05 : 0.44,
                  ),
                  SizedBox(
                    height: 9,
                  ),

                  // ________________________+_____

                  widget.uiddd == FirebaseAuth.instance.currentUser!.uid
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ElevatedButton.icon(
                              onPressed: () {},
                              icon: Icon(
                                Icons.edit,
                                size: 24,
                                color: Colors.grey,
                              ),
                              label: Text(
                                "Edit profile",
                                style: TextStyle(fontSize: 17),
                              ),
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                  Color.fromARGB(0, 90, 103, 223),
                                ),
                                padding: MaterialStateProperty.all(
                                    EdgeInsets.symmetric(
                                        vertical: widthScreen > 600 ? 19 : 10,
                                        horizontal: 33)),
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(7),
                                    side: BorderSide(
                                        color:
                                            Color.fromARGB(109, 255, 255, 255),
                                        style: BorderStyle.solid),
                                  ),
                                ),
                              ),
                            ),
                            ElevatedButton.icon(
                              onPressed: () {},
                              icon: Icon(
                                Icons.logout,
                                size: 24.0,
                              ),
                              label: Text(
                                "Log out",
                                style: TextStyle(fontSize: 17),
                              ),
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                  Color.fromARGB(143, 255, 55, 112),
                                ),
                                padding: MaterialStateProperty.all(
                                    EdgeInsets.symmetric(
                                        vertical: widthScreen > 600 ? 19 : 10,
                                        horizontal: 33)),
                                shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(7))),
                              ),
                            ),
                          ],
                        )

                      // __________________________________
                      : showFollow
                          ? ElevatedButton(
                              onPressed: () async {
                                followers--;
                                setState(() {
                                  showFollow = false;
                                });

                                await FirebaseFirestore.instance
                                    .collection("userSSS")
                                    .doc(widget.uiddd)
                                    .update({
                                  "followers": FieldValue.arrayRemove(
                                      [FirebaseAuth.instance.currentUser!.uid])
                                });

                                await FirebaseFirestore.instance
                                    .collection("userSSS")
                                    .doc(FirebaseAuth.instance.currentUser!.uid)
                                    .update({
                                  "following":
                                      FieldValue.arrayRemove([widget.uiddd])
                                });
                              },
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      Color.fromARGB(143, 255, 55, 112)),
                                  padding: MaterialStateProperty.all(
                                    EdgeInsets.symmetric(
                                        vertical: 9, horizontal: 66),
                                  ),
                                  shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(7)))),
                              child: const Text(
                                "unfollow",
                                style: TextStyle(fontSize: 17),
                              ))

                          // __________________________________
                          : ElevatedButton(
                              onPressed: () async {
                                followers++;
                                setState(() {
                                  showFollow = true;
                                });

                                // widget.uiddd
                                await FirebaseFirestore.instance
                                    .collection("userSSS")
                                    .doc(widget.uiddd)
                                    .update({
                                  "followers": FieldValue.arrayUnion(
                                      [FirebaseAuth.instance.currentUser!.uid])
                                });

                                await FirebaseFirestore.instance
                                    .collection("userSSS")
                                    .doc(FirebaseAuth.instance.currentUser!.uid)
                                    .update({
                                  "following":
                                      FieldValue.arrayUnion([widget.uiddd])
                                });
                              },
                              style: ButtonStyle(
                                  padding: MaterialStateProperty.all(
                                    EdgeInsets.symmetric(
                                        vertical: 9, horizontal: 77),
                                  ),
                                  shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(7)))),
                              child: const Text(
                                "Follow",
                                style: TextStyle(fontSize: 17),
                              )),

                  SizedBox(
                    height: 9,
                  ),
                  Divider(
                    color: Colors.white,
                    thickness: widthScreen > 600 ? 0.05 : 0.44,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  FutureBuilder(
                    future: FirebaseFirestore.instance
                        .collection('postSSS')
                        .where("uid", isEqualTo: widget.uiddd)
                        .get(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.hasError) {
                        return Text("Something went wrong");
                      }

                      if (snapshot.connectionState == ConnectionState.done) {
                        return Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: GridView.builder(
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        childAspectRatio: 3 / 2,
                                        crossAxisSpacing: 10,
                                        mainAxisSpacing: 10),
                                itemCount: snapshot.data!.docs.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return ClipRRect(
                                      borderRadius: BorderRadius.circular(9),
                                      child: Image.network(
                                        snapshot.data!.docs[index]["imgPost"],
                                        loadingBuilder:
                                            (context, child, progress) {
                                          return progress == null
                                              ? child
                                              : Center(
                                                  child:
                                                      CircularProgressIndicator());
                                        },
                                        fit: BoxFit.fill,

                                        // "https://www.flypgs.com/blog/wp-content/uploads/2019/04/dogal-anit-1.jpg"
                                      ));
                                }),
                          ),
                        );
                      }

                      return Center(
                          child: CircularProgressIndicator(
                        color: Colors.white,
                      ));
                    },
                  )
                ],
              ),
            ),
          );
  }
}
