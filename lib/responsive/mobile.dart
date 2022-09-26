import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:insta/screens/add_post.dart';

import 'package:insta/screens/favourt.dart';
import 'package:insta/screens/home.dart';
import 'package:insta/screens/profile.dart';
import 'package:insta/screens/search.dart';


import '../screens/add_post_text.dart';
import '../screens/forgot_passowrd.dart';
import '../screens/main_home.dart';
import '../screens/verify_email.dart';
import '../shared/colors.dart';

class MobileScreen extends StatefulWidget {
  const MobileScreen({super.key});

  @override
  State<MobileScreen> createState() => _MobileScreenState();
}

class _MobileScreenState extends State<MobileScreen> {
  final PageController _pageController = PageController();
  int currentPage = 0;

  

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text("Mobile Screen"),
      // ),
      bottomNavigationBar: CupertinoTabBar(
          // activeColor: primaryColor,
          // inactiveColor: secondaryColor,
          onTap: (index) {
            // navigate to the tabed page
            _pageController.jumpToPage(index);
            setState(() {
              currentPage = index;
            });

          },
          backgroundColor: mobileBackgroundColor,
          items:  [
             BottomNavigationBarItem(
                icon: Icon(
                  Icons.home_outlined,
                  color: currentPage == 0 ? primaryColor : secondaryColor,
                ),
                label: ""),
            BottomNavigationBarItem(
                icon: Icon(Icons.search_outlined,
                 color: currentPage == 1 ? primaryColor : secondaryColor,
                
                ), label: ""),
             BottomNavigationBarItem(
                icon: Icon(Icons.add_circle_outline, color: currentPage == 2 ? primaryColor : secondaryColor,), label: ""),
            BottomNavigationBarItem(
                icon: Icon(Icons.favorite_outline, 
                color: currentPage == 3 ? primaryColor : secondaryColor,), label: ""),
            BottomNavigationBarItem(
                icon: Icon(Icons.person_outline,
                color: currentPage == 4 ? primaryColor : secondaryColor,), label: ""),
                BottomNavigationBarItem(
                icon: Icon(Icons.home_max,
                color: currentPage == 5 ? primaryColor : secondaryColor,), label: ""),
          ]),
      body: PageView(
        onPageChanged: (index) {},
        physics: const NeverScrollableScrollPhysics(),
        controller: _pageController,
        children:  [
          // ForgotPassword(),
          // VerifyEmailPage(),
          AddPostText(),
          MainHome(uiddd: FirebaseAuth.instance.currentUser!.uid,),
          const Home(),
          const Search(),
          const AddPost(),
          const Favourt(),
          Profile(uiddd: FirebaseAuth.instance.currentUser!.uid,),
          
        ],
      ),
    );
  }
}
