import 'package:flutter/material.dart';
import 'package:medhealth/theme.dart';

class ButtonPrimary extends StatelessWidget {
  final String text;
  final Function onTap;
  ButtonPrimary({
    super.key,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 100,
      height: 50,
      child: ElevatedButton(
        onPressed: onTap(),
        style: ElevatedButton.styleFrom(
            primary: greenColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20))),
        child: Text(text),
      ),
    );
  }
}
