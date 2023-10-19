import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:water_order/utils/colors.dart';
import 'package:water_order/view_model/cart_provider.dart';
import 'package:water_order/widget/cart/cart_items.dart';

class MyCart extends ConsumerStatefulWidget {
  const MyCart({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyCartState();
}

class _MyCartState extends ConsumerState<MyCart> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final cartState = ref.watch(cartSNProvider);
    final cartStateNotifier = ref.watch(cartSNProvider.notifier);
    return SizedBox(
      height: size.height * .95,
      width: size.width,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: appColor,
              padding: EdgeInsets.only(
                  top: size.height * .05,
                  right: size.width * .04,
                  left: size.width * .04,
                  bottom: size.height * .03),
              height: size.height * .14,
              width: size.width,
              child: TextFormField(
                cursorHeight: 20,
                style: getstyle(fontsize: 16),
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  prefixIcon: const Icon(
                    Icons.search,
                    color: Colors.black,
                    size: 25,
                  ),
                  hintText: "Search for your orders",
                  hintStyle: getstyle(fontsize: 16),
                  enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(10)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8, top: 8),
                  child: RichText(
                      text: TextSpan(children: [
                    TextSpan(text: "Subtotal ", style: getstyle()),
                    TextSpan(
                        text: "\$3,454 ",
                        style: getstyle(fontweight: FontWeight.w700)),
                  ])),
                ),
                cartStateNotifier.isLoading
                    ? Center(
                        child: LoadingAnimationWidget.inkDrop(
                            color: appColor, size: 40),
                      )
                    : SizedBox(
                        height: size.height * .75,
                        child: ListView.builder(
                          padding: EdgeInsets.zero,
                          itemCount: cartState.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: size.height * .001),
                              child: cartItem(
                                size,
                                context,
                                cartStateNotifier,
                                cartState[index],
                              ),
                            );
                          },
                        ),
                      )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
