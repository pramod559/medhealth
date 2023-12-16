// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:medhealth/network/api/url_api.dart';
import 'package:medhealth/network/model/pref_profile_model.dart';

import 'package:medhealth/network/model/product_model.dart';
import 'package:medhealth/pages/main_page.dart';
import 'package:medhealth/theme.dart';
import 'package:medhealth/widget/button_primary.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailProduct extends StatefulWidget {
  final ProductModel productModel;
  const DetailProduct({
    super.key,
    required this.productModel,
  });

  @override
  State<DetailProduct> createState() => _DetailProductState();
}

class _DetailProductState extends State<DetailProduct> {
  final priceFormat = NumberFormat("#,##0", "EN_US");

  late String userID;
  getPref() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      userID = sharedPreferences.getString(PrefProfile.idUser)!;
    });
  }

  // Future<void> addToCart() async {
  //   try {
  //     var urlAddToCart = Uri.parse(BASEURL.addToCart);
  //     final response = await http.post(urlAddToCart, body: {
  //       "id_user": userID,
  //       "id_product": widget.productModel.idProduct,
  //     });

  //     if (response.statusCode == 200) {
  //       final data = jsonDecode(response.body);
  //       int value = data['value'];
  //       String message = data['message'];

  //       if (value == 1) {
  //         print(message);
  //         Navigator.pop(context);
  //         setState(() {});
  //       } else {
  //         print(message);
  //         // Handle the case where value is not 1 (e.g., display an error message)
  //         setState(() {});
  //       }
  //     } else {
  //       // Handle non-200 status code (e.g., display an error message)
  //       print('Failed to add to cart. Status code: ${response.statusCode}');
  //       setState(() {});
  //     }
  //   } catch (error) {
  //     // Handle other errors that might occur during the request
  //     print('Error adding to cart: $error');
  //     setState(() {});
  //   }
  // }
  addToCart() async {
    var urlAddToCart = Uri.parse(BASEURL.addToCart);
    final response = await http.post(urlAddToCart, body: {
      "id_user": userID,
      "id_product": widget.productModel.idProduct,
    });

    final data = jsonDecode(response.body);
    int value = data['value'];
    String message = data['message'];

    if (value == 1) {
      //  print(message);
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) => AlertDialog(
                title: const Text("Information"),
                content: Text(message),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MainPage()),
                          (route) => false);
                    },
                    child: const Text("ok"),
                  ),
                ],
              ));
      setState(() {});
    } else {
//      print(message);

      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) => AlertDialog(
                title: const Text("Information"),
                content: Text(message),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("ok"),
                  ),
                ],
              ));
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    getPref();
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
                  const SizedBox(
                    width: 30,
                  ),
                  Text(
                    "Detail Product",
                    style: regularTextStyle.copyWith(
                      fontSize: 25,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            Container(
              height: 200,
              color: whiteColor,
              child: Image.network(widget.productModel.imageProduct),
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.productModel.nameProduct,
                    style: regularTextStyle.copyWith(fontSize: 20),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    widget.productModel.description,
                    style: regularTextStyle.copyWith(
                        fontSize: 16, color: greyBoldColor),
                    textAlign: TextAlign.justify,
                  ),
                  const SizedBox(
                    height: 64,
                  ),
                  Row(
                    children: [
                      const Spacer(),
                      Text(
                          "Rp ${priceFormat.format(int.parse(widget.productModel.price))}",
                          style: boldTextStyle.copyWith(fontSize: 20)),
                    ],
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: ButtonPrimary(
                      onTap: () {
                        addToCart();
                      },
                      text: "ADD TO CART",
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

//part 4 27:33