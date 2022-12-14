import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../shared/colors.dart';


import '../shared/post_design.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final double widthScreen = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: widthScreen> 600 ? webBackgroundColor :  mobileBackgroundColor,
      appBar: widthScreen > 1024 ? null 
      :AppBar(
        backgroundColor: mobileBackgroundColor,
        centerTitle: false,
        title: SvgPicture.asset(
          "assets/img/instagram.svg",
          color: primaryColor,
          height: widthScreen > 600 ? widthScreen * 0.05 :32,
        ),
        actions: [
          SizedBox(
            
            
            width: widthScreen * 0.22,
            child: FittedBox(
              alignment: Alignment.centerRight,
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.end,
              // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
            
                IconButton(
                  onPressed: () {}, icon: const Icon(Icons.messenger_outline, )),
              IconButton(onPressed: () async {
                setState(() async{
                  await FirebaseAuth.instance.signOut();
                });
              }, icon: const Icon(Icons.logout_outlined, color: Colors.red, )),
            
              ],),
            ),
          ),
          
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('postSSS').orderBy("datePublished", descending: true).snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator(color: Colors.white,));
        }

        return ListView(
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
          Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
            return PostDesign(data: data,);
          }).toList(),
        );
      },
    )
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
    );
  }
}
