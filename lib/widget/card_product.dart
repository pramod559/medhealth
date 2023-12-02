import 'package:flutter/material.dart';

import 'package:medhealth/theme.dart';

class CardProduct extends StatelessWidget {
  final String? imageProduct;
  final String? nameProduct;
  final String? price;

  const CardProduct({
    super.key,
    this.imageProduct,
    this.nameProduct,
    this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Image.network(
            imageProduct!,
            width: 115,
            height: 76,
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            nameProduct!,
            style: regularTextStyle,
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 14,
          ),
          Text(
            price!,
            style: boldTextStyle,
          ),
        ],
      ),
    );
  }
}
