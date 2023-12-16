import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:medhealth/network/api/url_api.dart';
import 'package:medhealth/network/model/cart_model.dart';
import 'package:medhealth/network/model/pref_profile_model.dart';
import 'package:medhealth/pages/main_page.dart';
import 'package:medhealth/pages/success_checkout.dart';
import 'package:medhealth/theme.dart';
import 'package:medhealth/widget/button_primary.dart';
import 'package:medhealth/widget/widget_ilustration.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class CartPages extends StatefulWidget {
  final VoidCallback? method;
  CartPages({super.key, this.method});

//  late String? fullName, userID, address, phone;
  @override
  State<CartPages> createState() => _CartPagesState();
}

class _CartPagesState extends State<CartPages> {
  @override
  void initState() {
    super.initState();
    getPref();
    // fullName = '';
    // userID = '';
    // address = '';
    // phone = '';
  }

  final price = NumberFormat("#,##0", "EN_US");
  late String userID, fullName, address, phone;
  int delivery = 0;
  bool condition = true;
// g
// 40:33
//  1:09:23

  getPref() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      userID = sharedPreferences.getString(PrefProfile.idUser)!;
      fullName = sharedPreferences.getString(PrefProfile.name)!;
      address = sharedPreferences.getString(PrefProfile.address)!;
      phone = sharedPreferences.getString(PrefProfile.phone)!;
    });
    getCart();
    cartTotalPrice();
  }

  List<CartModel> listCart = [];
  getCart() async {
    listCart.clear();

    var urlGetCart = Uri.parse(BASEURL.getProductCart + userID);
    final response = await http.get(urlGetCart);
    if (response.statusCode == 200) {
      setState(() {
        final List<dynamic> data = jsonDecode(response.body);
        for (Map item in data) {
          listCart.add(CartModel.fromJson(item));
        }
      });
      //print(response.body);
    } else {
      const Center(child: Text("data not parsing"));
    }
  }

  updateQuantity(String tipe, String model) async {
    var urlUpdateQuantity = Uri.parse(BASEURL.updateQuantityProductCart);
    final response = await http
        .post(urlUpdateQuantity, body: {"cartID": model, "tipe": tipe});
    final data = jsonDecode(response.body);
    int value = data['value'];
    String message = data['message'];
    if (value == 1) {
      print(message);
      setState(() {
        getPref();
        widget.method!();
      });
    } else {
      print(message);
      setState(() {
        getPref();
      });
    }
  }

  checkout() async {
    var urlCheckout = Uri.parse(BASEURL.checkout);
    final respose = await http.post(urlCheckout, body: {"idUser": userID});
    final data = jsonDecode(respose.body);
    int value = data['value'];
    String message = data['message'];

    if (value == 1) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => SuccessCheckout(),
          ),
          (route) => false);
    } else {
      print(message);
    }
  }

  var sumPrice = "0";
  int totalPayment = 0;
  cartTotalPrice() async {
    var urlTotalPrice = Uri.parse(BASEURL.totalPriceCart + userID);
    final response = await http.get(urlTotalPrice);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      String total = data['Total'];
      setState(() {
        sumPrice = total;

        totalPayment = sumPrice == 0 ? 0 : int.parse(sumPrice) + delivery;
      });
      print(sumPrice);
    } else {
      print("error in sumPrice");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: listCart.isEmpty
          ? const SizedBox()
          : Container(
              padding: const EdgeInsets.all(24),
              height: 220,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                color: Color(0xfffcfcfc),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Total Items",
                        style: regularTextStyle.copyWith(
                            fontSize: 16, color: greyBoldColor),
                      ),
                      Text(
                        "IDR ${price.format(int.parse(sumPrice))}",
                        style: regularTextStyle.copyWith(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Delivery Fee",
                        style: regularTextStyle.copyWith(
                            fontSize: 16, color: greyBoldColor),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        delivery == 0 ? "FREE" : delivery as String,
                        style: regularTextStyle.copyWith(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Total Payment",
                        style: regularTextStyle.copyWith(
                            fontSize: 16, color: greyBoldColor),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "IDR ${price.format(totalPayment)}",
                        style: regularTextStyle.copyWith(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: ButtonPrimary(
                      onTap: () {
                        checkout();
                      },
                      text: "CHECKOUT NOW",
                    ),
                  )
                ],
              ),
            ),
      body: SafeArea(
          child: ListView(
        padding: EdgeInsets.only(bottom: 220),
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
                const SizedBox(width: 20),
                Text(
                  "My Cart ",
                  style: regularTextStyle.copyWith(fontSize: 25),
                ),
              ],
            ),
          ),
          listCart.isEmpty
              ? Container(
                  padding: const EdgeInsets.all(24),
                  margin: const EdgeInsets.only(top: 30),
                  child: WidgetIlustration(
                    image: "assets/empty_cart_ilustration.png",
                    title: "Oops, there are no products in your cart",
                    subtitle1: "Your cart is still empty, browse the ",
                    subtitle2: "attractive products from MEDHEALTH",
                    child: Container(
                      margin: const EdgeInsets.only(top: 30),
                      width: MediaQuery.of(context).size.width,
                      child: ButtonPrimary(
                        text: "SHOPPING NOW",
                        onTap: () {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const MainPage()),
                              (route) => false);
                        },
                      ),
                    ),
                  ),
                )
              : Container(
                  padding: const EdgeInsets.all(20),
                  height: 166,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Delivery Destination",
                        style: regularTextStyle.copyWith(fontSize: 18),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      //"Name"
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Name",
                            style: regularTextStyle.copyWith(fontSize: 18),
                          ),
                          Text(
                            fullName,
                            style: regularTextStyle.copyWith(fontSize: 18),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      // " Address "
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            " Address ",
                            style: regularTextStyle.copyWith(fontSize: 18),
                          ),
                          Text(
                            address,
                            style: regularTextStyle.copyWith(fontSize: 18),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      //"Phone",
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Phone",
                            style: regularTextStyle.copyWith(fontSize: 18),
                          ),
                          Text(
                            phone,
                            style: regularTextStyle.copyWith(fontSize: 18),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
          ListView.builder(
            itemCount: listCart.length,
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            itemBuilder: (context, i) {
              var x = listCart[i];

              return Container(
                padding: const EdgeInsets.all(24),
                color: whiteColor,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.network(
                          x.image,
                          width: 115,
                          height: 100,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width - 200,
                          child: Column(
                            children: [
                              Text(
                                "IMBOOST 10 TABLETS",
                                style: regularTextStyle.copyWith(fontSize: 16),
                              ),
                              Row(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      updateQuantity("tambah", x.idCart);
                                    },
                                    icon: Icon(
                                      Icons.add_circle,
                                      color: greenColor,
                                    ),
                                  ),
                                  Text(x.quantity),
                                  IconButton(
                                    onPressed: () {
                                      updateQuantity("kurang", x.idCart);
                                    },
                                    icon: const Icon(
                                      Icons.remove_circle,
                                      color: Color(0xfff0997a),
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                "IDR ${price.format(int.parse(x.price))}",
                                style: regularTextStyle.copyWith(fontSize: 16),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    const Divider()
                  ],
                ),
              );
            },
          ),
        ],
      )),
    );
  }
}
