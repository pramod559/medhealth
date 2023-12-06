import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:medhealth/theme.dart';

class CardProduct extends StatelessWidget {
  final String imageProduct;
  final String nameProduct;
  final String price;

  const CardProduct({
    super.key,
    required this.imageProduct,
    required this.nameProduct,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    final priceFormat = NumberFormat("#,##0", "EN_US");

    return Container(
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Image.network(
            imageProduct,
            width: 115,
            height: 76,
          ),
          const SizedBox(
            height: 7,
          ),
          Text(
            nameProduct,
            style: regularTextStyle,
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 7,
          ),
          Text(
            priceFormat.format(int.parse(price)),
            style: boldTextStyle,
          ),
        ],
      ),
    );
  }
}
