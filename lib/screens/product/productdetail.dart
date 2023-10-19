// ignore_for_file: prefer_const_constructors

import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:water_order/models/product_model.dart';
import 'package:water_order/services/payment_page.dart';
import 'package:water_order/utils/colors.dart';
import 'package:water_order/view_model/cart_provider.dart';
import 'package:water_order/widget/appbar.dart';
import 'package:water_order/widget/loading.dart';
import 'package:water_order/widget/shimmerproductdetail.dart';
import 'package:water_order/widget/snakbar.dart';

class ProductDetail extends StatefulWidget {
  final ProductModel productdata;
  const ProductDetail({super.key, required this.productdata});

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  bool _isloading = true;
  int itemcount = 0;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 500), () {
      if (mounted) {
        setState(() {
          _isloading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        bottomSheet: _isloading
            ? SizedBox(
                height: 0,
                width: 0,
              )
            : getbottomsheet(size, context, itemcount, widget.productdata),
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: appColor,
          title: Text(
            "Product Details",
            style: appstyle(),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  // Navigator.push(context, route)
                },
                icon: Icon(
                  CupertinoIcons.cart_fill,
                  color: Colors.white,
                  size: 25,
                ))
          ],
        ),
        body: SizedBox(
          height: _isloading ? size.height : size.height * .819,
          child: _isloading
              ? shimmerProductDetail(size)
              : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Image.asset(
                                  "assets/images/register.png",
                                  height: size.height * .07,
                                ),
                                Container(
                                  width: size.width * .2,
                                  decoration: BoxDecoration(
                                      color: appColor,
                                      borderRadius: BorderRadius.circular(2)),
                                  alignment: Alignment.center,
                                  child: Text(
                                      "${widget.productdata.disc_percent!}% Off",
                                      style: getstyle(
                                          color: Colors.white, fontsize: 16)),
                                )
                              ]),
                          SizedBox(
                            // color: appColor,
                            height: size.height * .4,
                            child: CarouselSlider(
                              items: [
                                widget.productdata.image1!,
                                widget.productdata.image2!
                              ].map((i) {
                                print(i);
                                return Builder(
                                  builder: (BuildContext context) {
                                    // return Container(
                                    //   clipBehavior: Clip.hardEdge,
                                    //   decoration: BoxDecoration(
                                    //       borderRadius:
                                    //           BorderRadius.circular(8),
                                    //       color: Color.fromARGB(
                                    //           255, 218, 220, 218),
                                    //       image: DecorationImage(
                                    //           image: AssetImage(
                                    //               "assets/images/$i"),
                                    //           fit: BoxFit.contain)),
                                    // );
                                    return CachedNetworkImage(
                                      imageUrl: i,
                                      imageBuilder: (context, imageProvider) {
                                        return Container(
                                          height: size.height * .15,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.rectangle,
                                              color: Colors.black,
                                              image: DecorationImage(
                                                  image: imageProvider,
                                                  fit: BoxFit.fill)),
                                        );
                                      },
                                      placeholder: (context, url) {
                                        return LoadingAnimationWidget.inkDrop(
                                            color: appColor, size: 40);
                                      },
                                    );
                                  },
                                );
                              }).toList(),
                              options: CarouselOptions(
                                clipBehavior: Clip.hardEdge,
                                reverse: false,
                                height: size.height * .35,
                                autoPlay: true,
                                enlargeFactor: .2,
                                enlargeCenterPage: true,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: size.height * .03,
                          ),
                          Text(
                            widget.productdata.product_name!,
                            style: getstyle(fontweight: FontWeight.w600),
                            maxLines: 4,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(
                            height: size.height * .01,
                          ),
                          Text(
                            widget.productdata.mrp.toString(),
                            style: TextStyle(
                                fontSize: 14,
                                decoration: TextDecoration.lineThrough),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(
                            height: size.height * .01,
                          ),
                          Text(
                            widget.productdata.disc_price.toString(),
                            style: getstyle(fontweight: FontWeight.w600),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  // to increase the rating
                                },
                                child: Container(
                                  padding: EdgeInsets.all(8),
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 4, vertical: 6),
                                  decoration: BoxDecoration(
                                      color: appColor,
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Row(
                                    children: [
                                      Text(
                                        "300",
                                        style: getstyle(
                                            color: Colors.white, fontsize: 14),
                                      ),
                                      SizedBox(
                                        width: size.width * .03,
                                      ),
                                      Icon(
                                        Icons.star,
                                        color: Colors.white,
                                        size: 20,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: RichText(
                                      text: TextSpan(children: [
                                    TextSpan(
                                        style: getstyle(fontsize: 16),
                                        text: "Quantity left : "),
                                    TextSpan(
                                        text: widget.productdata.quantity_left
                                            .toString(),
                                        style: getstyle(
                                            fontsize: 17,
                                            fontweight: FontWeight.w600))
                                  ])))
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 8),
                            height: 1,
                            decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(2)),
                          ),
                          SizedBox(
                            height: size.height * .02,
                          ),
                          Text(
                            "Description",
                            style: getstyle(fontweight: FontWeight.w500),
                          ),
                          SizedBox(
                            height: size.height * .01,
                          ),
                          Text(
                            """  iet massa tincidunt nunc pulvinar. Nulla aliquet porttitor lacus luctus. Orci porta non pulvinar neque. Lobortis scelerisque fermentum dui faucibus in ornare quam viverra. Nunc eget lorem dolor sed viverra ipsum. Nunc consequat interdum varius sit amet mattis vulputate enim nulla. Natoque penatibus et magnis dis parturient montes nascetur ridiculus. Ultrices in iaculis nunc sed augue lacus viverra. Eu turpis egestas pretium aenean. Felis eget velit aliquet sagittis. At tellus at urna condimentum mattis pellentesque id nibh tortor. Amet commodo nulla facilisi nullam vehicula. Magna fringilla urna porttitor rhoncus dolor purus. Faucibus vitae aliquet nec ullamcorper. Faucibus interdum posuere lorem ipsum. Ac ut consequat semper viverra nam libero. Donec ac odio tempor orci dapibus ultrices in. Purus ut faucibus pulvinar elementum integer enim. Orci sagittis eu volutpat odio facilisis mauris.
                              iet massa tincidunt nunc pulvinar. Nulla aliquet porttitor lacus luctus. Orci porta non pulvinar neque. Lobortis scelerisque fermentum dui faucibus in ornare quam viverra. Nunc eget lorem dolor sed viverra ipsum. Nunc consequat interdum varius sit amet mattis vulputate enim nulla. Natoque penatibus et magnis dis parturient montes nascetur ridiculus. Ultrices in iaculis nunc sed augue lacus viverra. Eu turpis egestas pretium aenean. Felis eget velit aliquet sagittis. At tellus at urna condimentum mattis pellentesque id nibh tortor. Amet commodo nulla facilisi nullam vehicula. Magna fringilla urna porttitor rhoncus dolor purus. Faucibus vitae aliquet nec ullamcorper. Faucibus interdum posuere lorem ipsum. Ac ut consequat semper viverra nam libero. Donec ac odio tempor orci dapibus ultrices in. Purus ut faucibus pulvinar elementum integer enim. Orci sagittis eu volutpat odio facilisis mauris.
                              iet massa tincidunt nunc pulvinar. Nulla aliquet porttitor lacus luctus. Orci porta non pulvinar neque. Lobortis scelerisque fermentum dui faucibus in ornare quam viverra. Nunc eget lorem dolor sed viverra ipsum. Nunc consequat interdum varius sit amet mattis vulputate enim nulla. Natoque penatibus et magnis dis parturient montes nascetur ridiculus. Ultrices in iaculis nunc sed augue lacus viverra. Eu turpis egestas pretium aenean. Felis eget velit aliquet sagittis. At tellus at urna condimentum mattis pellentesque id nibh tortor. Amet commodo nulla facilisi nullam vehicula. Magna fringilla urna porttitor rhoncus dolor purus. Faucibus vitae aliquet nec ullamcorper. Faucibus interdum posuere lorem ipsum. Ac ut consequat semper viverra nam libero. Donec ac odio tempor orci dapibus ultrices in. Purus ut faucibus pulvinar elementum integer enim. Orci sagittis eu volutpat odio facilisis mauris.
                              iet massa tincidunt nunc pulvinar. Nulla aliquet porttitor lacus luctus. Orci porta non pulvinar neque. Lobortis scelerisque fermentum dui faucibus in ornare quam viverra. Nunc eget lorem dolor sed viverra ipsum. Nunc consequat interdum varius sit amet mattis vulputate enim nulla. Natoque penatibus et magnis dis parturient montes nascetur ridiculus. Ultrices in iaculis nunc sed augue lacus viverra. Eu turpis egestas pretium aenean. Felis eget velit aliquet sagittis. At tellus at urna condimentum mattis pellentesque id nibh tortor. Amet commodo nulla facilisi nullam vehicula. Magna fringilla urna porttitor rhoncus dolor purus. Faucibus vitae aliquet nec ullamcorper. Faucibus interdum posuere lorem ipsum. Ac ut consequat semper viverra nam libero. Donec ac odio tempor orci dapibus ultrices in. Purus ut faucibus pulvinar elementum integer enim. Orci sagittis eu volutpat odio facilisis mauris.
                              iet massa tincidunt nunc pulvinar. Nulla """,
                            style: getstyle(
                                fontweight: FontWeight.w500, fontsize: 15),
                            maxLines: 10,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(
                            height: size.height * .02,
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 8),
                            height: 1,
                            decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(2)),
                          ),
                          SizedBox(
                            height: size.height * .02,
                          ),
                          Text(
                            "Ratings & Reviews",
                            style: getstyle(fontweight: FontWeight.w500),
                          ),
                          SizedBox(
                            height: size.height * .01,
                          ),
                          Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  // to increase the rating
                                },
                                child: Container(
                                  padding: EdgeInsets.all(8),
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 4, vertical: 6),
                                  decoration: BoxDecoration(
                                      color: appColor,
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Row(
                                    children: [
                                      Text(
                                        "300",
                                        style: getstyle(
                                            color: Colors.white, fontsize: 14),
                                      ),
                                      SizedBox(
                                        width: size.width * .03,
                                      ),
                                      Icon(
                                        Icons.star,
                                        color: Colors.white,
                                        size: 20,
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ]),
                  ),
                ),
        ));
  }
}

Container getbottomsheet(
    Size size, BuildContext context, int? itemcount, ProductModel cartItem) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: size.height * .01),
    color: Color.fromARGB(255, 255, 255, 255),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SizedBox(
          height: size.height * .06,
          width: size.width * .4,
          child: ElevatedButton(
              style: ButtonStyle(
                  shadowColor: MaterialStateProperty.all(Colors.transparent)),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PaymentPagge(ammount: cartItem.disc_price!,),
                  ),
                );
              },
              child: Text(
                "Buy Jar",
                style: getstyle(color: Colors.white),
              )),
        ),
        SizedBox(
          height: size.height * .06,
          width: size.width * .4,
          child: ElevatedButton(
              style: ButtonStyle(
                  shadowColor: MaterialStateProperty.all(Colors.transparent)),
              onPressed: () async {
                itemcount = await getItemCount(context, size, cartItem);

                if (itemcount != null) {
                  print(itemcount);
                } else {
                  // user have not selected the product
                }
                // process the next operations
              },
              child: Text(
                "Add to Cart",
                style: getstyle(color: Colors.white),
              )),
        )
      ],
    ),
  );
}

Future<int?> getItemCount(
    BuildContext context, Size size, ProductModel cartItem) async {
  Completer<int?> completer = Completer<int?>();
  ValueNotifier<int> count = ValueNotifier<int>(0);

  showDialog<int>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text("Choose the number of items"),
        content: SizedBox(
          height: size.height * .15,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: size.width * .1,
                    child: TextButton(
                        onPressed: () {
                          if (count.value == 0) {
                            count.value = 0;
                          } else {
                            count.value = count.value - 1;
                          }
                        },
                        child: Text(
                          " - ",
                          style: getstyle(
                              color: Colors.black,
                              fontsize: size.height * .025,
                              fontweight: FontWeight.w800),
                        )),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    color: Colors.black,
                    width: 1,
                  ),
                  SizedBox(
                    width: size.width * .04,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 2, right: 2),
                    child: ValueListenableBuilder(
                      valueListenable: count,
                      builder: (context, value, child) {
                        return Text(
                          value.toString(),
                          style: getstyle(
                              fontsize: size.height * .026,
                              color: Colors.black),
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    width: size.width * .04,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    color: Colors.black,
                    width: 1,
                  ),
                  SizedBox(
                    width: size.width * .1,
                    child: TextButton(
                        onPressed: () {
                          count.value = count.value + 1;
                        },
                        child: Text(
                          " + ",
                          style: getstyle(
                              color: Colors.black,
                              fontsize: size.height * .025,
                              fontweight: FontWeight.w800),
                        )),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ButtonStyle(
                          shadowColor:
                              MaterialStateProperty.all(Colors.transparent)),
                      child: Text(
                        "Cancel",
                        style: getstyle(fontsize: 16, color: Colors.white),
                      )),
                  Consumer(
                    builder: (context, ref, child) {
                      return ElevatedButton(
                          onPressed: () {
                            //TODO: api call to add item in cart
                            if (count.value != 0) {
                              final itemToAdd =
                                  cartItem.copyWith(quantity: count.value);
                              ref
                                  .read(cartSNProvider.notifier)
                                  .addItemIntocart(itemToAdd);
                              Navigator.of(context).pop(count.value);
                              showCustomSnackBar("Item added to cart");
                            } else {
                              showCustomSnackBar("Invalid item count");
                            }
                          },
                          style: ButtonStyle(
                              shadowColor: MaterialStateProperty.all(
                                  Colors.transparent)),
                          child: Text(
                            "Confirm",
                            style: getstyle(fontsize: 16, color: Colors.white),
                          ));
                    },
                  )
                ],
              )
            ],
          ),
        ),
      );
    },
  ).then((value) => completer.complete(value));

  return completer.future;
}
