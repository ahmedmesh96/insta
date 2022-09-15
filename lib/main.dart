import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:insta/provider/user_provider.dart';
import 'package:insta/responsive/mobile.dart';
import 'package:insta/responsive/responsive.dart';
import 'package:insta/responsive/web.dart';
import 'package:insta/screens/register.dart';
import 'package:insta/screens/sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:insta/shared/snack_bar.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
      apiKey: "AIzaSyC8EjiJQzXVJVfU8CMgzbqo2iwcvnVWnx8",
      authDomain: "instagram-tut-3502d.firebaseapp.com",
      projectId: "instagram-tut-3502d",
      storageBucket: "instagram-tut-3502d.appspot.com",
      messagingSenderId: "737392623661",
      appId: "1:737392623661:web:1c37f9689bc8cc2d1c38a4",
    ));
  } else {
    await Firebase.initializeApp();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {return UserProvider();},
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData.dark(),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                  child: CircularProgressIndicator(
                color: Colors.white,
              ));
            } else if (snapshot.hasError) {
              return showSnackBar(context, "Something went wrong");
            } else if (snapshot.hasData) {
              return const Responsive(
                myMobileScreen: MobileScreen(),
                myWebScreen: WebScreen(),
              );
            } else {
              return const Login();
            }
          },
        ),
        // home: const Responsive(
        //   myMobileScreen: MobileScreen(),
        //   myWebScreen: WebScreen(),
        // ),
      ),
    );
  }
}
