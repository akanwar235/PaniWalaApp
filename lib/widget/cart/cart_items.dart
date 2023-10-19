import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:water_order/models/product_model.dart';
import 'package:water_order/utils/colors.dart';
import 'package:water_order/view_model/cart_provider.dart';

Widget cartItem(Size size, BuildContext context, CartProvider cartStateNotifier,
    ProductModel cartItem) {
  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          // Displaying the item image
          Container(
            height: size.height * .2,
            width: size.width * .45,
            // decoration: const BoxDecoration(
            //   image: DecorationImage(
            //     image: AssetImage("assets/images/register.png"),
            //     fit: BoxFit.cover,
            //   ),
            // ),
            child: CachedNetworkImage(
              imageUrl: cartItem.image1!,
              imageBuilder: (context, imageProvider) {
                return Container(
                  height: size.height * .15,
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: Colors.black,
                      image: DecorationImage(
                          image: imageProvider, fit: BoxFit.fill)),
                );
              },
              placeholder: (context, url) {
                return Center(
                    child: LoadingAnimationWidget.inkDrop(
                        color: appColor, size: 40));
              },
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Displaying item name
              SizedBox(
                width: size.width * .45,
                child: Text(
                  // "Water Jar with capacity of 5 liters",
                  "${cartItem.product_name}",
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: getstyle(fontweight: FontWeight.w600, fontsize: 17),
                ),
              ),
              // Displaying discount percentage
              Container(
                margin: const EdgeInsets.all(4),
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: appColor, // Assuming 'appColor' is defined somewhere.
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  "${cartItem.disc_percent}% off",
                  // "97% off",
                  style: getstyle(color: Colors.white, fontsize: 14),
                ),
              ),
              // Displaying the item price
              Text(
                "₹ ${cartItem.disc_price}",
                style: getstyle(fontweight: FontWeight.w600),
              ),
            ],
          )
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // 'Delete' button to remove the item from the cart
          Padding(
            padding: EdgeInsets.only(right: size.width * .04),
            child: SizedBox(
              width: size.width * .38,
              height: size.height * .05,
              child: ElevatedButton(
                onPressed: () {
                  cartStateNotifier.removeItemFromCart(cartItem);
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.red),
                  shadowColor: MaterialStateProperty.all(Colors.transparent),
                ),
                child: Text(
                  "Delete",
                  style: getstyle(color: Colors.white),
                ),
              ),
            ),
          )
        ],
      ),
      SizedBox(
        height: size.height * .02,
      ),
      // A horizontal line to separate items
      Container(
        color: const Color.fromARGB(255, 96, 95, 95),
        width: size.width * .9,
        height: 1,
      )
    ],
  );
}
