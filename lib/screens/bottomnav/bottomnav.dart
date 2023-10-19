// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:water_order/screens/cart/cart.dart';
import 'package:water_order/screens/home/home.dart';
import 'package:water_order/screens/profile/profile.dart';
import 'package:water_order/utils/colors.dart';
import 'package:water_order/widget/shimmerhome.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  List pages = [const Profile(), const HomeScreen(), const MyCart()];
  int _page = 1;
  Color _iconColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: CurvedNavigationBar(
        index: _page,
        backgroundColor: appColor,
        height: 50,
        buttonBackgroundColor: Colors.black,
        color: Colors.white,
        items: <Widget>[
          Icon(
            Icons.person,
            size: 30,
            color:
                _page == 0 ? _iconColor : const Color.fromARGB(255, 63, 63, 63),
          ),
          Icon(
            Icons.home,
            size: 30,
            color:
                _page == 1 ? _iconColor : const Color.fromARGB(255, 63, 63, 63),
          ),
          Icon(
            CupertinoIcons.cart_fill,
            size: 30,
            color:
                _page == 2 ? _iconColor : const Color.fromARGB(255, 63, 63, 63),
          ),
        ],
        onTap: (index) {
          setState(() {
            _page = index;
            _iconColor = Colors.white;
          });
        },
      ),
      body: StreamBuilder(
        stream: FirebaseDatabase.instance.ref().child("isappCrashed").onValue,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var isappCrashed = snapshot.data!.snapshot.value;
            if (isappCrashed == false) {
              return pages[_page];
            } else {
              return Center(
                child: Text(

                  "For some reason app is closed !",

                  style: getstyle(fontsize: 20),
                ),
              );
            }
          }

          return shimmerHome(size);
        },
      ),
    );
  }
}
