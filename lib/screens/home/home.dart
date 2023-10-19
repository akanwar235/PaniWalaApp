import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:water_order/screens/maps/map.dart';
import 'package:water_order/screens/product/allproduct.dart';
import 'package:water_order/screens/searchbar/searchbar.dart';
import 'package:water_order/services/module.dart';
import 'package:water_order/utils/colors.dart';
import 'package:water_order/view_model/cart_provider.dart';
import 'package:water_order/widget/shimmerhome.dart';
import 'package:water_order/widget/snakbar.dart';

import '../../widget/productItem.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isloading = true;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 500), () {
      _isloading = false;

      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    // Duration
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: _isloading
          ? shimmerHome(size)
          : Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  color: appColor,
                  height: size.height * .2,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 20),
                    child: Column(
                      children: [
                        const Spacer(),
                        Row(
                          children: [
                            const Icon(
                              Icons.location_on_sharp,
                              color: Colors.white,
                              size: 25,
                            ),
                            TextButton(
                                onPressed: () {
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => const Maps()),
                                      (route) => false);
                                },
                                child: Text(
                                  "Add Location",
                                  style: getstyle(
                                      color: Colors.white, fontsize: 16),
                                )),
                            SizedBox(
                              width: size.width * .45,
                            ),
                            const Icon(
                              Icons.notifications_rounded,
                              color: Colors.white,
                              size: 25,
                            )
                          ],
                        ),
                        const Spacer(),
                        searchbar(size, context),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          color: appColor,
                          height: size.height * .28,
                          child: CarouselSlider(
                            items: [
                              "post of the day",
                              "hangout",
                              "quiz",
                              "ar feature name",
                            ].map((i) {
                              return Builder(
                                builder: (BuildContext context) {
                                  return Container(
                                    height: size.height * .2,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: Colors.white,
                                        image: const DecorationImage(
                                            image: AssetImage(
                                                "assets/images/otp.gif"))),
                                  );
                                },
                              );
                            }).toList(),
                            options: CarouselOptions(
                              height: size.height * .23,
                              autoPlay: true,
                              enlargeFactor: .2,
                              enlargeCenterPage: true,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          child: Text(
                            "Categories",
                            style: getstyle(
                                fontsize: 25, fontweight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          height: size.height * .01,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          child: SizedBox(
                              height: size.height * .2,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: 10,
                                itemBuilder: (context, index) {
                                  return SizedBox(
                                    width: size.width * .45,
                                    child: Card(
                                      clipBehavior: Clip.hardEdge,
                                      // color: Colors.blue,
                                      child: Image.asset(
                                        "assets/images/register.png",
                                        fit: BoxFit.fitWidth,
                                      ),
                                    ),
                                  );
                                },
                              )),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Products",
                                style: getstyle(
                                    fontsize: 25, fontweight: FontWeight.bold),
                              ),
                              TextButton(
                                  // open new product page
                                  onPressed: () {
                                    // Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //         builder: (context) => AllProduct(
                                    //               products: [],
                                    //             )));
                                  },
                                  child: Text(
                                    "View all",
                                    style: getstyle(
                                        color: appColor,
                                        fontsize: 20,
                                        fontweight: FontWeight.w700),
                                  ))
                            ],
                          ),
                        ),
                        Consumer(
                          builder: (context, ref, child) {
                            final productListAsyncVal =
                                ref.watch(prodductListFutureProvider);
                            return productListAsyncVal.when(
                              data: (data) {
                                return data.fold((l) {
                                  showApiRequestErrorSnackBar(l.message);
                                  return const SizedBox();
                                }, (r) {
                                  // TODO: replace with list or gird
                                  // return Container(
                                  //   margin: const EdgeInsets.symmetric(
                                  //       horizontal: 5, vertical: 12),
                                  //   padding: const EdgeInsets.symmetric(
                                  //       vertical: 0, horizontal: 5),
                                  //   height: size.height * 0.5,
                                  //   decoration: BoxDecoration(
                                  //     color: const Color.fromARGB(
                                  //         255, 226, 222, 222),
                                  //     borderRadius: BorderRadius.circular(10),
                                  //   ),
                                  // child: Column(
                                  //   children: [
                                  //     Row(
                                  //       mainAxisAlignment:
                                  //           MainAxisAlignment.spaceEvenly,
                                  //       children: [
                                  //         productItem(context, size, r[2]),
                                  //         productItem(context, size, r[2])
                                  //       ],
                                  //     ),
                                  //   ],
                                  // ),
                                  return Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    height: size.height * .6,
                                    child: GridView.builder(
                                      itemCount: r.length,
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 2,
                                              crossAxisSpacing: 8.0,
                                              mainAxisSpacing: 8.0,
                                              childAspectRatio: .5),
                                      itemBuilder: (context, index) {
                                        return productItem(
                                            context, size, r[index]);
                                      },
                                    ),
                                  );
                                  // );
                                });
                              },
                              error: (error, stackTrace) => Center(
                                child: Text(
                                  error.toString(),
                                ),
                              ),

                              // TO do -> to make the shimmer effect equal with the loading time of the data
                              loading: () => const Center(
                                child: CircularProgressIndicator(),
                              ),
                            );
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}

InkWell searchbar(Size size, BuildContext context) {
  return InkWell(
    onTap: () {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const searchBar()));
    },
    child: Container(
      padding: const EdgeInsets.all(4),
      height: size.height * .055,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(8)),
      child: Row(children: [
        const Icon(
          Icons.search,
        ),
        SizedBox(
          width: size.width * .03,
        ),
        Text(
          "Search here",
          style: getstyle(fontsize: 16),
        )
      ]),
    ),
  );
}
