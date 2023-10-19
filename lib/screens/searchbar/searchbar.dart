// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:water_order/screens/home/home.dart';

import '../../utils/colors.dart';

class searchBar extends StatefulWidget {
  const searchBar({super.key});

  @override
  State<searchBar> createState() => _searchBarState();
}

class _searchBarState extends State<searchBar> {
  final FocusNode _textFieldFocusNode = FocusNode();
  String tofind = "";

  @override
  void dispose() {
    _textFieldFocusNode.dispose();
    super.dispose();
  }

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      FocusScope.of(context).requestFocus(_textFieldFocusNode);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            splashRadius: 1,
            icon: Icon(
              Icons.arrow_back_ios_rounded,
              color: Colors.black,
              size: 30,
            )),
        backgroundColor: Colors.white,
        title: searchbar(size, context),
      ),
      body: Container(
          padding: EdgeInsets.only(top: 12),
          height: size.height,
          width: size.width,
          child: ListView.builder(
            itemCount: 0,
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                padding: EdgeInsets.all(8),
                height: size.height * .06,
                width: size.width * .7,
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 229, 226, 226),
                    borderRadius: BorderRadius.circular(4)),
                child: Text(
                  "Cloud Drops - RB",
                  style: getstyle(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              );
            },
          )),
    );
  }

  SizedBox searchbar(Size size, BuildContext context) {
    return SizedBox(
      height: size.height * .055,
      child: TextFormField(
        focusNode: _textFieldFocusNode,
        onChanged: (e) {
          tofind += e;
        },
        cursorColor: appColor,
        cursorHeight: 25,
        style: getstyle(fontsize: 18),
        decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.search,
              color: Colors.black,
              size: 25,
            ),
            fillColor: Colors.grey.shade200,
            filled: true,
            hintText: "Search here",
            hintStyle: getstyle(fontsize: 14),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent)),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent))),
      ),
    );
  }
}
