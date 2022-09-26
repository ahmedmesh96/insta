import 'package:flutter/material.dart';


class ConnectionScreen extends StatefulWidget {
  const ConnectionScreen({super.key});

  @override
  State<ConnectionScreen> createState() => _ConnectionScreenState();
}

class _ConnectionScreenState extends State<ConnectionScreen> {



  void updateList(String value) {
    // this is the function that will filter our list

  }


  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: Container(
            height: screenHeight,
            width: screenWidth,
            decoration: const BoxDecoration(
              gradient: RadialGradient(
                colors: [
                  Color.fromARGB(255, 35, 40, 113),
                  Color.fromARGB(255, 14, 15, 34)
                ],
              ),
            ),
      
            child: Column(
              children: [
              Row(
                children: [
                  IconButton(onPressed: (){
                    setState(() {
                      Navigator.pop(context);
                    });
                    
                  }, icon: const Icon(Icons.arrow_back_ios_new_outlined , color: Colors.white,)),
                  // SizedBox(width: screenWidth * 0.2,),
                  const Center(child:   Text("My Connections", style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),),),

                  

      
              ],),
              TextField(
              decoration: InputDecoration(
                hintMaxLines: 1,
                filled: true,
                fillColor: Colors.white24,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  // borderSide: BorderSide.none,
                ),
                hintText: "Search Connections",hintStyle: const TextStyle(color: Colors.white) , 
                prefixIcon: const Icon(Icons.search, color: Colors.white, size: 30,),
                prefixIconColor: Colors.red
              ),
                  ),
            ]),
            
            
            ),
      ),
    );
  }
}