import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:medhealth/network/api/url_api.dart';
import 'package:medhealth/network/model/product_model.dart';
import 'package:medhealth/theme.dart';
import 'package:medhealth/widget/card_category.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<CategoryWithProduct> listCategory = [];
  Future<void> getCategory() async {
    listCategory.clear();
    var urlCategory = Uri.parse(BASEURL.categoryWithProduct);
    try {
      final response = await http.get(urlCategory);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        setState(() {
          for (Map<String, dynamic> item in data) {
            listCategory.add(CategoryWithProduct.fromJson(item));
            if (kDebugMode) {
              print(listCategory[0].idCategory);
            }
          }
        });
      } else {
        if (kDebugMode) {
          print("Failed to load data . Status code : ${response.statusCode}");
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error fetching data : $e");
      }
    }
  }

  @override
  void initState() {
    super.initState();
    getCategory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(24, 30, 24, 30),
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
                    const SizedBox(
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
                  icon: const Icon(Icons.shopping_cart_outlined),
                  color: greenColor,
                )
              ],
            ),
            const SizedBox(
              height: 24,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
              height: 55,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color(0xffe4faf0)),
              child: TextField(
                decoration: InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: const Icon(
                      Icons.search,
                      color: Color(0xffb1d8b2),
                    ),
                    hintText: "Search medicine ...",
                    hintStyle: regularTextStyle.copyWith(
                        color: const Color(0xffb0d8b2))),
              ),
            ),
            const SizedBox(
              height: 32,
            ),
            Text(
              "Medicine & Vitamins by Category",
              style: regularTextStyle.copyWith(fontSize: 16),
            ),

//            CardProduct(),
            GridView.builder(
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4),
              itemBuilder: (BuildContext context, int index) {
                final x = listCategory[index];
                return CardCategory(
                  imageCategory: x.image,
                  nameCategory: x.category,
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
