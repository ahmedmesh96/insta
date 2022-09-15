import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:insta/firbase_services/firestore.dart';
import 'package:provider/provider.dart';

import '../provider/user_provider.dart';
import '../shared/colors.dart';

import 'package:path/path.dart' show basename;

class AddPost extends StatefulWidget {
  const AddPost({super.key});

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {

  final decController = TextEditingController();


  bool isLoading = false;
  Uint8List? imgPath;
  String? imgName;

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
      }
    } catch (e) {
      print("Error => $e");
    }
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

        // Container(
        //   padding: EdgeInsets.all(22),
        //   height: 170,
        //   child: Column(
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     children: [
        //       GestureDetector(
        //         onTap: () async {
        //           await uploadImage2Screen(ImageSource.camera);
        //         },
        //         child: Row(
        //           children: [
        //             Icon(
        //               Icons.camera,
        //               size: 30,
        //             ),
        //             SizedBox(
        //               width: 11,
        //             ),
        //             Text(
        //               "From Camera",
        //               style: TextStyle(fontSize: 20),
        //             )
        //           ],
        //         ),
        //       ),
        //       SizedBox(
        //         height: 22,
        //       ),
        //       GestureDetector(
        //         onTap: () {
        //           uploadImage2Screen(ImageSource.gallery);
        //         },
        //         child: Row(
        //           children: [
        //             Icon(
        //               Icons.photo_outlined,
        //               size: 30,
        //             ),
        //             SizedBox(
        //               width: 11,
        //             ),
        //             Text(
        //               "From Gallery",
        //               style: TextStyle(fontSize: 20),
        //             )
        //           ],
        //         ),
        //       ),
        //     ],
        //   ),
        // );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final allDataFromDB = Provider.of<UserProvider>(context).getUser;

    return imgPath == null
        ? Scaffold(
            backgroundColor: mobileBackgroundColor,
            body: Center(
                child: IconButton(
              onPressed: () {
                showmodel();
              },
              icon: const Icon(
                Icons.upload,
                size: 44,
              ),
            )),
          )
        : Scaffold(
            backgroundColor: mobileBackgroundColor,
            appBar: AppBar(
              actions: [
                TextButton(
                    onPressed: () async {
                      setState(() {
                        isLoading = true;
                      });

                      await FireStoreMethods().uploadPost(
                          imgName: imgName,
                          imgPath: imgPath,
                          description: decController.text,
                          profileImg: allDataFromDB!.profileImg,
                          username: allDataFromDB.username,
                          context: context);

                          setState(() {
                        isLoading = false;
                        imgPath = null;
                      });
                    },
                    child: Text(
                      "Post",
                      style: TextStyle(
                          color: Colors.blueAccent,
                          fontSize: 19,
                          fontWeight: FontWeight.bold),
                    ))
              ],
              backgroundColor: mobileBackgroundColor,
              leading: IconButton(
                onPressed: () {
                  setState(() {
                    imgPath = null;
                  });
                },
                icon: const Icon(Icons.arrow_back),
              ),
            ),
            body: Column(
              children: [
                isLoading
                    ? LinearProgressIndicator()
                    : Divider(
                        thickness: 1,
                        height: 30,
                      ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 10),
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color.fromARGB(124, 0, 102, 255)),
                      child: CircleAvatar(
                        radius: 33,
                        backgroundImage: NetworkImage(allDataFromDB!.profileImg
                            // "https://www.indiewire.com/wp-content/uploads/2022/01/AP21190389554952-e1643225561835.jpg"
                            ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.3,
                      child: TextField(
                        controller: decController,
                        maxLines: 8,
                        decoration: InputDecoration(
                            hintText: "write a caption...",
                            border: InputBorder.none),
                      ),
                    ),
                    Container(
                      width: 66,
                      height: 74,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: MemoryImage(imgPath!), fit: BoxFit.cover
                            // image: NetworkImage("https://www.flypgs.com/blog/wp-content/uploads/2019/04/dogal-anit-1.jpg"), fit: BoxFit.cover
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
