import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:insta/firbase_services/firestore.dart';
import 'package:insta/responsive/mobile.dart';
import 'package:insta/responsive/responsive.dart';
import 'package:insta/responsive/web.dart';
import 'package:insta/screens/home.dart';
import 'package:provider/provider.dart';

import '../provider/user_provider.dart';
import '../shared/colors.dart';

import 'package:path/path.dart' show basename;

import '../shared/snack_bar.dart';
import 'add_post_text.dart';

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


  uploadText2Screen()async{
    Navigator.pop(context);
    Navigator.push(context, MaterialPageRoute(builder: (context) => AddPostText(),));
    



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
            ),
            SimpleDialogOption(
              onPressed: () async {
                // Navigator.of(context).pop();
                await uploadText2Screen();
              },
              padding: const EdgeInsets.all(20),
              child: const Text(
                "Post Text",
                style: TextStyle(fontSize: 18),
              ),
            )
          ],
        );

        
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
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const Responsive(myMobileScreen: MobileScreen(), myWebScreen: WebScreen(),),));
                      setState(() {
                        decController.clear();
                      });
                    },
                    child: const Text(
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
                    ? const LinearProgressIndicator()
                    : const Divider(
                        thickness: 1,
                        height: 30.0,
                      ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      margin: const  EdgeInsets.only(left: 10.0),
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
                        decoration: const InputDecoration(
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
