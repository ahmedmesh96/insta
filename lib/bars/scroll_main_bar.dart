import 'package:flutter/material.dart';


import '../widget/custom_buttun_scroll_bar.dart';


class ScrollMainBar extends StatefulWidget {
  const ScrollMainBar({super.key});

  @override
  State<ScrollMainBar> createState() => _ScrollMainBarState();
}

class _ScrollMainBarState extends State<ScrollMainBar> {
  int _selectedIndex = 0;

 

  @override
  Widget build(BuildContext context) {
    final double heightScreen = MediaQuery.of(context).size.height;
    final double widthScreen = MediaQuery.of(context).size.width;
    
    return widthScreen > 1000 ? 

    Stack(
      alignment: Alignment.center,
      children: [
      Container( 
      height: widthScreen > 1000 ? widthScreen * 0.07: widthScreen * 0.1,
      width: widthScreen,
      color: Colors.white24,
      
    ),

      SizedBox(
        width: widthScreen * 0.95,
        child: FittedBox(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomButtonScrollBar(
                onTap: () {
                  setState(() {
                    _selectedIndex = 0;
                    
                  });
                },
                selected: _selectedIndex == 0,
                text: "News",
              ),
              CustomButtonScrollBar(
                onTap: () {
                  
                },
                selected: _selectedIndex == 1,
                text: "Wellness",
              ),
              CustomButtonScrollBar(
                onTap: () {
                  setState(() {
                    _selectedIndex = 2;
                  });
                },
                selected: _selectedIndex == 2,
                text: "Calendar",
              ),
              CustomButtonScrollBar(
                onTap: () {
                  setState(() {
                    _selectedIndex = 3;
                  });
                },
                selected: _selectedIndex == 3,
                text: "Favours",
              ),
              Stack(
                children: [
                  CustomButtonScrollBar(
                    onTap: () {
                      setState(() {
                        _selectedIndex = 4;
                      });
                    },
                    selected: _selectedIndex == 4,
                    text: "Live",
                  ),
                  Positioned(
                    top: 7.8,
                    right: 7,
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle),
                      // color: Colors.red,
                      width: 9,
                      height: 9,
                    ),
                  ),
                ],
              ),
              CustomButtonScrollBar(
                onTap: () {
                  setState(() {
                    _selectedIndex = 5;
                  });
                },
                selected: _selectedIndex == 5,
                text: "Retreat",
              ),
              CustomButtonScrollBar(
                onTap: () {
                  setState(() {
                    _selectedIndex = 6;
                  });
                },
                selected: _selectedIndex == 6,
                text: "BoB",
              ),
            ],
          ),
        ),
      )

    ],)

    

    :
    
    
    Container( 
      height: widthScreen > 600 ? widthScreen * 0.07: widthScreen * 0.1,
      width: widthScreen,
      color: Colors.white24,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomButtonScrollBar(
              onTap: () {
                setState(() {
                  _selectedIndex = 0;
                  
                });
              },
              selected: _selectedIndex == 0,
              text: "News",
            ),
            CustomButtonScrollBar(
              onTap: () {
                
              },
              selected: _selectedIndex == 1,
              text: "Wellness",
            ),
            CustomButtonScrollBar(
              onTap: () {
                setState(() {
                  _selectedIndex = 2;
                });
              },
              selected: _selectedIndex == 2,
              text: "Calendar",
            ),
            CustomButtonScrollBar(
              onTap: () {
                setState(() {
                  _selectedIndex = 3;
                });
              },
              selected: _selectedIndex == 3,
              text: "Favours",
            ),
            Stack(
              children: [
                CustomButtonScrollBar(
                  onTap: () {
                    setState(() {
                      _selectedIndex = 4;
                    });
                  },
                  selected: _selectedIndex == 4,
                  text: "Live",
                ),
                Positioned(
                  top: 7.8,
                  right: 7,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle),
                    // color: Colors.red,
                    width: 9,
                    height: 9,
                  ),
                ),
              ],
            ),
            CustomButtonScrollBar(
              onTap: () {
                setState(() {
                  _selectedIndex = 5;
                });
              },
              selected: _selectedIndex == 5,
              text: "Retreat",
            ),
            CustomButtonScrollBar(
              onTap: () {
                setState(() {
                  _selectedIndex = 6;
                });
              },
              selected: _selectedIndex == 6,
              text: "BoB",
            ),
          ],
        ),
      ),
    );
  }
}
