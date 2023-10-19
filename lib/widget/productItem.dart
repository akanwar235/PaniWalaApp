import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:water_order/models/product_model.dart';
import 'package:water_order/screens/product/productdetail.dart';

import '../utils/colors.dart';

InkWell productItem(BuildContext context, Size size, ProductModel productData) {
  return InkWell(
    onTap: () {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ProductDetail(productdata: productData)));
    },
    child: Container(
      height: size.height * .4,
      width: size.width * .45,
      decoration: BoxDecoration(
          color: Colors.blue.shade300, borderRadius: BorderRadius.circular(10)),
      child: Stack(
        children: [
          Positioned(
            top: size.height * .015,
            right: -size.width * .1,
            left: 0,
            child: Row(
              children: [
                Image.asset(
                  "assets/images/register.png",
                  height: 50,
                ),
                Transform.rotate(
                  angle: .8,
                  child: Container(
                    alignment: Alignment.center,
                    color: Colors.black,
                    height: size.height * .04,
                    width: size.width * .38,
                    child: Transform.rotate(
                      angle: 0,
                      child: Text(
                        // "100% OFF",
                        "${productData.disc_percent!}% OFF",
                        style: getstyle(color: Colors.white, fontsize: 17),
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: size.height * .1,
            // child: Image.asset("assets/images/register.png"))
            child: CachedNetworkImage(
              imageUrl:
                  // "https://th.bing.com/th/id/OIP.X8q1KaRQJY59HzhcGF63QgHaFW?pid=ImgDet&rs=1",
                  productData.image2!,
              imageBuilder: (context, imageProvider) {
                return Container(
                  height: size.height * .15,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black,
                      image: DecorationImage(
                          image: imageProvider, fit: BoxFit.contain)),
                );
              },
              placeholder: (context, url) {
                return const Center(child: CircularProgressIndicator());
              },
            ),
          ),
          Positioned(
            top: size.height * .3,
            left: size.width * .02,
            child: SizedBox(
              width: size.width * .42,
              child: Text(
                // "Eastern Aqua - RB kkafalkf flakjfa fkajsl faskfa lfj ajfal",
                productData.product_name!,
                style: getstyle(
                    color: Colors.white,
                    fontweight: FontWeight.w500,
                    fontsize: 17),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          Positioned(
            top: size.height * .33,
            left: size.width * .02,
            child: SizedBox(
              width: size.width * .42,
              child: Text(
                // "\$65 / 20L",
                "₹ ${productData.mrp}",
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: GoogleFonts.inter().fontFamily,
                    fontSize: 15,
                    decoration: TextDecoration.lineThrough),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          Positioned(
            top: size.height * .36,
            left: size.width * .02,
            child: SizedBox(
              width: size.width * .42,
              child: Text(
                // "\$60 / 20L",
                "₹ ${productData.disc_price}",
                style: getstyle(
                    color: Colors.white,
                    fontweight: FontWeight.w600,
                    fontsize: 17),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
