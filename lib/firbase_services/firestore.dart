import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:insta/firbase_services/storage.dart';

import '../models/post.dart';
import '../shared/snack_bar.dart';

import 'package:uuid/uuid.dart';

class FireStoreMethods {
  uploadPost(
      {required imgName,
      required imgPath,
      required description,
      required profileImg,
      required username,
      required context}) async {
    String message = "ERROR => Not starting the code";
    try {
      //_________________________________________________________________________

      String urlll = await getImgURL(
          imgName: imgName,
          imgPath: imgPath,
          folderName: 'imgPosts/${FirebaseAuth.instance.currentUser!.uid}');

      //_________________________________________________________________________

      // firebase firestore (Database)
      CollectionReference posts =
          FirebaseFirestore.instance.collection('postSSS');

      String newId = const Uuid().v1();

      PostData postt = PostData(
          datePublished: DateTime.now(),
          description: description,
          imgPost: urlll,
          likes: [],
          postId: newId,
          profileImg: profileImg,
          uid: FirebaseAuth.instance.currentUser!.uid,
          username: username);

      posts
          .doc(newId)
          .set(postt.convert2Map())
          .then((value) => print("done...."))
          .catchError((error) => print("Failed to post: $error"));

      message = 'Posted successfully';
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, "ERROR : ${e.code} ");
    } catch (e) {
      print(e);
    }
    showSnackBar(context, message);
  }
}
