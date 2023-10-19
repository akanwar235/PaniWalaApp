import 'package:flutter/material.dart';
import 'package:water_order/models/product_model.dart';
import 'package:water_order/widget/appbar.dart';

import '../../widget/productItem.dart';

class AllProduct extends StatefulWidget {
  final List<ProductModel> products;
  const AllProduct({super.key, required this.products});

  @override
  State<AllProduct> createState() => AllProductState();
}

class AllProductState extends State<AllProduct> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: appbar("All Products"),
      body: GridView.builder(
        itemCount: widget.products.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
            childAspectRatio: .5),
        itemBuilder: (context, index) {
          return productItem(context, size, widget.products[index]);
        },
      ),
    );
  }
}
