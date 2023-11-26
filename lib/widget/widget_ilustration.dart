import 'package:flutter/material.dart';
import 'package:medhealth/theme.dart';

class WidgetIlustration extends StatelessWidget {
  final Widget? child;
  final String image;
  final String title;
  final String subtitle1;
  final String subtitle2;
  const WidgetIlustration({
    super.key,
    this.child,
    required this.image,
    required this.title,
    required this.subtitle1,
    required this.subtitle2,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          //    "splash_ilustration.png",
          image,
          width: 150,
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
//          "title",
          title,
          style: regularTextStyle.copyWith(
            fontSize: 25,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 11,
        ),
        Column(
          children: [
            Text(
              // "subtitle1",
              subtitle1,
              style: regularTextStyle.copyWith(
                fontSize: 15,
                color: greyLightColor,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
//              "subtitle2",
              subtitle2,

              style: regularTextStyle.copyWith(
                fontSize: 15,
                color: greyLightColor,
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            child ?? const SizedBox(),
          ],
        )
      ],
    );
  }
}
