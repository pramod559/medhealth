import 'package:flutter/material.dart';
import 'package:medhealth/theme.dart';

class ButtonPrimary extends StatelessWidget {
  final String text;
  final Function? onTap;
  final Color? color;
  const ButtonPrimary({
    super.key,
    required this.text,
    this.onTap,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width - 100,
      height: 50,
      child: ElevatedButton(
        onPressed: onTap as void Function()?,
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            foregroundColor: greenColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20))),
        child: Text(text, style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
