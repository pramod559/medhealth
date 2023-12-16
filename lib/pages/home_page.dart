//import 'package:flutter/foundation.dart';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:medhealth/network/api/url_api.dart';
import 'package:medhealth/network/model/pref_profile_model.dart';
import 'package:medhealth/network/model/product_model.dart';
import 'package:medhealth/pages/cart_pages.dart';
import 'package:medhealth/pages/detail_product.dart';
import 'package:medhealth/pages/search_product.dart';
import 'package:medhealth/theme.dart';
import 'package:medhealth/widget/card_category.dart';
import 'package:http/http.dart' as http;
import 'package:medhealth/widget/card_product.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late int index;
  bool filter = false;
  List<CategoryWithProduct> listCategory = [];
  getCategory() async {
    listCategory.clear();
    var urlCategory = Uri.parse(BASEURL.categoryWithProduct);

    try {
      final response = await http.get(urlCategory);
      if (response.statusCode == 200) {
        setState(() {
          final data = jsonDecode(response.body);

          //  if (data.isNotEmpty) {
          for (Map<String, dynamic> item in data) {
            listCategory.add(CategoryWithProduct.fromJson(item));
            //  }
          }
        });
        getProduct();
        totalCart();
      } else {
        print("Failed to load data . Status code : ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching data : $e");
    }
  }

  List<ProductModel> listProduct = [];

  Future<void> getProduct() async {
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
        } else {
          print("Invalid data format. Expected a List.");
        }
      } else {
        print("Failed to load data. Status code: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching data: $e");
    }
  }

  late String userID;
  getPref() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      userID = sharedPreferences.getString(PrefProfile.idUser)!;
    });
  }

  var jumlahCart = "0";
  totalCart() async {
    var urlGfetTotalCArt = Uri.parse(BASEURL.getTotalCart + userID);
    final response = await http.get(urlGfetTotalCArt);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body)[0];
      String jumlah = data['jumlah'];
      setState(() {
        jumlahCart = jumlah;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getPref();
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
                      "assets/logo.png",
                      width: 155,
                    ),
                    const SizedBox(
                      height: 10,
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
                Stack(children: [
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CartPages(method: totalCart),
                        ),
                      );

                      // Navigator.pushAndRemoveUntil(
                      //     context,
                      //     MaterialPageRoute(
                      //       builder: (context) => CartPages(),
                      //     ),
                      //     (route) => false);
                    },
                    icon: const Icon(Icons.shopping_cart_outlined),
                    color: greenColor,
                  ),
                  jumlahCart == "0"
                      ? SizedBox()
                      : Positioned(
                          right: 10,
                          top: 10,
                          child: Container(
                            height: 13,
                            width: 13,
                            decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(30)),
                            child: Center(
                              child: Text(
                                jumlahCart,
                                style: regularTextStyle.copyWith(
                                  color: whiteColor,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ),
                        )
                ])
              ],
            ),
            const SizedBox(
              // height: 24,
              height: 20,
            ),
            InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SearchProduct()));
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color(0xffe4faf0)),
                child: TextField(
                  enabled: false,
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
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              "Medicine & Vitamins by Category",
              style: regularTextStyle.copyWith(fontSize: 16),
            ),

//            CardProduct(),
            GridView.builder(
              physics: const ClampingScrollPhysics(),
              itemCount: listCategory.length,
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                mainAxisSpacing: 10,
              ),
              itemBuilder: (BuildContext context, int i) {
                final x = listCategory[i];
                return InkWell(
                  onTap: () {
                    setState(() {
                      index = i;
                      filter = true;
                    });
                  },
                  child: CardCategory(
                    imageCategory: x.image,
                    nameCategory: x.category,
                  ),
                );
              },
            ),
            const SizedBox(
              height: 32,
            ),
            filter
                ? index == 7
                    ? const Text("Feature on progress")
                    : GridView.builder(
                        physics: const ClampingScrollPhysics(),
                        itemCount: listCategory[index].product.length,
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                        ),
                        itemBuilder: (BuildContext context, int i) {
                          final y = listCategory[index].product[i];
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
                      )
                : GridView.builder(
                    physics: const ClampingScrollPhysics(),
                    itemCount: listProduct.length,
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 14,
                      mainAxisSpacing: 14,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      final y = listProduct[index];
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
                  )
          ],
        ),
      ),
    );
  }
}
