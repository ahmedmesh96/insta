import 'package:flutter/material.dart';

import '../widget/icon_top_bar.dart';




class TopIconsBar extends StatefulWidget {
  const TopIconsBar({super.key});

  @override
  State<TopIconsBar> createState() => _TopIconsBarState();
}

class _TopIconsBarState extends State<TopIconsBar> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
  
    return Row(
      children: [
        IconTopBar(
          icon: Icons.search,
          selected: _selectedIndex == 0,
          onPressed: () {
            setState(() {
              _selectedIndex = 0;
            });
          },
        ),
        InkWell(
          onTap: () {},
          child: Stack(
            children: [
              IconTopBar(
                icon: Icons.inbox,
                onPressed: () {
                  setState(() {
                    _selectedIndex = 1;
                  });
                },
                selected: _selectedIndex == 1,
              ),
              Positioned(
                top: 5,
                right: 5,
                child: CircleAvatar(
                  backgroundColor: Colors.amberAccent,
                  radius: screenWidth > 600 ? screenWidth * 0.01: screenWidth * 0.023,
                  child: FittedBox(child: Text("1",style: TextStyle(fontWeight: FontWeight.bold),)),
                ),
              ),
            
            ],
          ),
        ),
        IconTopBar(
          icon: Icons.send,
          onPressed: () {
            setState(() {
              _selectedIndex = 2;
            });
          },
          selected: _selectedIndex == 2,
        ),
        

       
      ],
    );
  }
}



