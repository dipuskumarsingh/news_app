

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/Ui/accountScreen.dart';
import 'package:news_app/Ui/bookMarkScreen.dart';
import 'package:news_app/Ui/discoverScreen.dart';
import 'package:news_app/Ui/uiHelper/textWidget.dart';

import 'homeScreen.dart';

class BottomNavigationScreen extends StatefulWidget{
  @override
  State<BottomNavigationScreen> createState() => _BottomNavigationScreenState();
}

class _BottomNavigationScreenState extends State<BottomNavigationScreen> {
  int selectIndex = 0;

  List<Widget> screenNavigation = [
    homeScreen(),
    discoverScreen(),
    bookmarkScreen(),
    accountScreen(),
  ];

  @override
  Widget build(BuildContext context){
    return Scaffold(
        body: screenNavigation [selectIndex],
        bottomNavigationBar: NavigationBar(
            destinations: [
              NavigationDestination(
                selectedIcon:
                    Icon(Icons.home_outlined,color: Colors.white,),
                  icon: Row(
                    children: [
                      Icon(Icons.home),
                      CustomText(text: " Home",)
                    ],
                  ), label: ""),
              NavigationDestination(
                selectedIcon: Icon(Icons.language_outlined,color: Colors.white,),
                  icon: Row(
                    children: [
                      Icon(Icons.language),
                      CustomText(text: " Discover",)
                    ],
                  ), label: ""),
              NavigationDestination(
                selectedIcon: Icon(Icons.bookmark_border,color: Colors.white,),
                  icon: Row(
                    children: [
                      Icon(Icons.bookmark),
                      CustomText(text: " Save",)
                    ],
                  ), label: ""),
              NavigationDestination(
                selectedIcon: Icon(Icons.person_2_outlined,color: Colors.white,),
                  icon: Row(
                    children: [
                      Icon(Icons.person_rounded),
                      CustomText(text: " Profile",)
                    ],
                  ), label: ""),
            ],
          height: 65,
          backgroundColor: Colors.white,
          labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
          indicatorColor:  Color(0xff0c87e4),
          indicatorShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          selectedIndex: selectIndex,
          onDestinationSelected: (value){
              selectIndex = value;
              setState(() {

              });
          },

        )
    );
  }
}