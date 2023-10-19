import 'package:flutter/material.dart';
import 'package:water_order/widget/appbar.dart';

class MyOrders extends StatefulWidget {
  const MyOrders({super.key});

  @override
  State<MyOrders> createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: appbar("My Orders"),
      body: GridView.builder(
        itemCount: 2,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, mainAxisSpacing: 8, crossAxisSpacing: 8),
        itemBuilder: (context, index) {
          return Container(
            color: Colors.black,
            // height: size.height * .8,
            child: SizedBox(
              height: size.height * .8,
              width: size.width * .6,
            ),
          );
        },
      ),
    );
  }
}
