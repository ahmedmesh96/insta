import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../firbase_services/firestore.dart';
import '../provider/user_provider.dart';
import '../responsive/mobile.dart';
import '../responsive/responsive.dart';
import '../responsive/web.dart';


class AddPostText extends StatefulWidget {
  const AddPostText({super.key});

  @override
  State<AddPostText> createState() => _AddPostTextState();
}

class _AddPostTextState extends State<AddPostText> {
   final textPostController = TextEditingController();


  bool isLoading = false;
  Uint8List? imgPath;
  String? imgName;
  
  get mobileBackgroundColor => null;



  @override
  Widget build(BuildContext context) {
    final allDataFromDB = Provider.of<UserProvider>(context).getUser;

    return Scaffold(
      appBar: AppBar(
              actions: [
                TextButton(
                    onPressed: () async {
                      setState(() {
                        isLoading = true;
                      });

                      await FireStoreMethods().uploadTextPost(
                          imgName: imgName,
                          // imgPath: imgPath,
                          textPost: textPostController.text,
                          profileImg: allDataFromDB!.profileImg,
                          username: allDataFromDB.username,
                          context: context);

                          setState(() {
                        isLoading = false;
                        imgPath = null;
                      });
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const Responsive(myMobileScreen: MobileScreen(), myWebScreen: WebScreen(),),));
                      setState(() {
                        textPostController.clear();
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
                        controller: textPostController,
                        maxLines: 8,
                        decoration: const InputDecoration(
                            hintText: "write a caption...",
                            border: InputBorder.none),
                      ),
                    ),
                    
                  ],
                ),
              ],
            ),
    );
  }
}