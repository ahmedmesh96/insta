import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';

getImgURL({required String imgName, required Uint8List imgPath, required String folderName}) async {
  // Upload image to firebase storage
  final storageRef = FirebaseStorage.instance.ref("$folderName/$imgName");
  // await storageRef.putFile(imgPath!);
  // use this code if u are using flutter web
  UploadTask uploadTask = storageRef.putData(imgPath);
  TaskSnapshot snap = await uploadTask;

// Get img url
  String urll = await snap.ref.getDownloadURL();

// Store img url in firestore[database]
  //  CollectionReference users = FirebaseFirestore.instance.collection('userSSS');
  //  users.doc(credential!.uid).set({"imgURL": url,});

  return urll;
}
