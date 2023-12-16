// ignore_for_file: non_constant_identifier_names, avoid_function_literals_in_foreach_calls, prefer_is_empty

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:medhealth/network/api/url_api.dart';
import 'package:medhealth/network/model/product_model.dart';
import 'package:medhealth/pages/detail_product.dart';
import 'package:medhealth/theme.dart';
import 'package:http/http.dart' as http;
import 'package:medhealth/widget/card_product.dart';
import 'package:medhealth/widget/widget_ilustration.dart';

class SearchProduct extends StatefulWidget {
  const SearchProduct({super.key});

  @override
  State<SearchProduct> createState() => _SearchProductState();
}

class _SearchProductState extends State<SearchProduct> {
  TextEditingController searchController = TextEditingController();
  List<ProductModel> listProduct = [];

  List<ProductModel> listSearchProduct = [];

  getProduct() async {
    listProduct.clear();
    var urlProduct = Uri.parse(BASEURL.getProduct);

    try {
      final response = await http.get(urlProduct);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data is List) {
          setState(() {
            for (Map<String, dynamic> product in data) {
              listProduct.add(ProductModel.fromJson(product));
            }
          });
        } else {}
      } else {
        print("Failed to load data. Status code: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching data: $e");
    }
  }

  SearchProduct(String text) {
    listSearchProduct.clear();
    if (text.isEmpty) {
      setState(() {});
    } else {
      listProduct.forEach((element) {
        if (element.nameProduct.toLowerCase().contains(text)) {
          listSearchProduct.add(element);
        }
      });
      setState(() {});
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProduct();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
              height: 70,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.arrow_back_rounded,
                        size: 32,
                        color: greenColor,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 5),
                      width: MediaQuery.of(context).size.width - 100,
                      height: 55,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color(0xffe4faf0)),
                      child: TextField(
                        onChanged: SearchProduct,
                        controller: searchController,
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
                  ]),
            ),
            searchController.text.isEmpty || listSearchProduct.length == 0
                ? const Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 24.0, vertical: 80),
                    child: WidgetIlustration(
                      image: "assets/no_data_liustration.png",
                      title: "There is no medicine that is looking for ",
                      subtitle1: "Please find the product you want ,",
                      subtitle2: " the product will aprear here ",
                    ),
                  )
                : Container(
                    padding: const EdgeInsets.all(24),
                    child: GridView.builder(
                      physics: const ClampingScrollPhysics(),
                      itemCount: listSearchProduct.length,
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        final y = listSearchProduct[index];
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        DetailProduct(productModel: y)));
                          },
                          child: CardProduct(
                            imageProduct: y.imageProduct,
                            nameProduct: y.nameProduct,
                            price: y.price,
                          ),
                        );
                      },
                    ),
                  )
          ],
        ),
      ),
    );
  }
}
//49:23