import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:water_order/utils/colors.dart';

Future showLoadingAnimation(BuildContext context) {
  return showDialog(
    context: context,
    builder: (context) {
      return WillPopScope(
          child: Center(
            child: LoadingAnimationWidget.inkDrop(color: appColor, size: 40),
          ),
          onWillPop: () async {
            return false;
          });
    },
  );
}
