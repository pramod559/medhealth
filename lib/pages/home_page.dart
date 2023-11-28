import 'package:flutter/material.dart';
import 'package:medhealth/theme.dart';
import 'package:medhealth/widget/card_category.dart';
import 'package:medhealth/widget/card_product.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.fromLTRB(24, 30, 24, 30),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      "logo.png",
                      width: 155,
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Text(
                      "Find a medicine or\n vitamins wiht MEDHEALTH!",
                      style: regularTextStyle.copyWith(
                        fontSize: 15,
                        color: greyBoldColor,
                      ),
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.shopping_cart_outlined),
                  color: greenColor,
                )
              ],
            ),
            SizedBox(
              height: 24,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 5),
              height: 55,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color(0xffe4faf0)),
              child: TextField(
                decoration: InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Icon(
                      Icons.search,
                      color: Color(0xffb1d8b2),
                    ),
                    hintText: "Search medicine ...",
                    hintStyle:
                        regularTextStyle.copyWith(color: Color(0xffb0d8b2))),
              ),
            ),
            SizedBox(
              height: 32,
            ),
            Text(
              "Medicine & Vitamins by Category",
              style: regularTextStyle.copyWith(fontSize: 16),
            ),
            CardProduct()
          ],
        ),
      ),
    );
  }
}
