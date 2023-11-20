import 'package:flutter/material.dart';

class GeneralLogoSpace extends StatelessWidget {
  final Widget child;
  GeneralLogoSpace({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(children: [
        const SizedBox(
          height: 50,
        ),
        Image.asset(
          "logo.png",
          width: 115,
        ),
        child ?? SizedBox()
      ]),
    );
  }
}
