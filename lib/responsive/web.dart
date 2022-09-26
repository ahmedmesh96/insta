import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:insta/shared/colors.dart';

import '../screens/add_post.dart';
import '../screens/favourt.dart';
import '../screens/home.dart';
import '../screens/main_home.dart';
import '../screens/profile.dart';
import '../screens/search.dart';

class WebScreen extends StatefulWidget {
  const WebScreen({super.key});

  @override
  State<WebScreen> createState() => _WebScreenState();
}

class _WebScreenState extends State<WebScreen> {
  final PageController _pageController = PageController();
  int page = 0;

  navigate2Screen(int indexx){
     _pageController.jumpToPage(indexx);

  }

  

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                navigate2Screen(0);
                setState(() {
                  page = 0;
                });
                
                
              },
              icon: Icon(
                Icons.home_outlined,
                color: page==0? primaryColor : secondaryColor,
                size: 40,
              )),
          IconButton(
              onPressed: () {
                navigate2Screen(1);
                setState(() {
                  page = 1;
                });

              },
              icon: Icon(
                Icons.search,
                color: page==1? primaryColor : secondaryColor,
                size: 40,

              )),
          IconButton(
              onPressed: () {
                navigate2Screen(2);
                setState(() {
                  page = 2;
                });

              },
              icon: Icon(
                Icons.add_circle_outline,
                color: page==2? primaryColor : secondaryColor,
                size: 40,

              )),
          IconButton(
              onPressed: () {
                navigate2Screen(3);
                setState(() {
                  page = 3;
                });

              },
              icon: Icon(
                Icons.favorite_outline,
                color: page==3? primaryColor : secondaryColor,
                size: 40,

              )),
          IconButton(
              onPressed: () {
                navigate2Screen(4);
                setState(() {
                  page = 4;
                });

              },
              icon: Icon(
                Icons.person_outline,
                color: page==4? primaryColor : secondaryColor,
                size: 40,

              )),
              
          IconButton(onPressed: () async {
            await FirebaseAuth.instance.signOut();
          }, icon: const Icon(Icons.logout_outlined, size: 40, color: Colors.red,)),

          IconButton(
              onPressed: () {
                navigate2Screen(5);
                setState(() {
                  page = 5;
                });

              },
              icon: Icon(
                Icons.home_max,
                color: page==3? primaryColor : secondaryColor,
                size: 40,

              )),
        ],
        backgroundColor: mobileBackgroundColor,
        title: SvgPicture.asset(
          "assets/img/instagram.svg",
          color: primaryColor,
          height: 44,
        ),
      ),
      body: PageView(
        onPageChanged: (index) {},
        physics: const NeverScrollableScrollPhysics(),
        controller: _pageController,
        children:  [
          MainHome(uiddd: FirebaseAuth.instance.currentUser!.uid,),
          const Home(),
          const Search(),
          const AddPost(),
          const Favourt(),
          Profile(uiddd: FirebaseAuth.instance.currentUser!.uid,),
          MainHome(uiddd: FirebaseAuth.instance.currentUser!.uid,)
        ],
      ),
      
    );
  }
}
