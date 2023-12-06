import 'package:flutter/material.dart';
// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:medhealth/network/api/url_api.dart';
import 'package:medhealth/network/model/pref_profile_model.dart';
import 'package:medhealth/pages/register_page.dart';

import 'package:medhealth/theme.dart';
import 'package:medhealth/widget/button_primary.dart';
import 'package:medhealth/widget/general_logo_space.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'main_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool _secureText = true;

  showHide() {
    setState(() {
      _secureText = !_secureText;
    });
  }

  loginsubmit(BuildContext context) async {
    var urlLogin = Uri.parse(BASEURL.apiLogin);
    final response = await http.post(urlLogin, body: {
      "email": emailController.text,
      "password": passwordController.text,
    });
    final data = jsonDecode(response.body);
    var value = data['value'];
    String message = data['message'];
    String idUser = data['user_id'];
    String name = data['name'];
    String email = data['email'];
    String phone = data['phone'];
    String address = data['address'];
    String createdAt = data['created_at'];

    // rest of your code...
    if (value == 1) {
      savePref(idUser, name, email, phone, address, createdAt);
      showDialog(
          //  barrierDismissible: false,
          context: context,
          builder: (context) => AlertDialog(
                title: const Text('Information'),
                content: Text(message),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MainPage(),
                        ),
                        (route) => false,
                      );
                      print(name);
                    },
                    child: const Text("ok"),
                  )
                ],
              ));
      setState(() {});
    } else {
      showDialog(
          //  barrierDismissible: false,
          context: context,
          builder: (context) => AlertDialog(
                title: const Text('Information'),
                content: Text(message),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("ok"))
                ],
              ));
      setState(() {});
    }
  }

  savePref(String idUser, String name, String email, String phone,
      String address, String createdAt) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      sharedPreferences.setString(PrefProfile.idUser, idUser);
      sharedPreferences.setString(PrefProfile.name, name);
      sharedPreferences.setString(PrefProfile.email, email);
      sharedPreferences.setString(PrefProfile.phone, phone);
      sharedPreferences.setString(PrefProfile.address, address);
      sharedPreferences.setString(PrefProfile.createdAt, createdAt);
    });
  }

  // late String name;
  // getPref() async {
  //   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //   name = sharedPreferences.getString(PrefProfile.name)!;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          const GeneralLogoSpace(),
          Container(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "LOGIN",
                  style: regularTextStyle,
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  "Register new your account",
                  style: regularTextStyle.copyWith(
                      fontSize: 15, color: greyLightColor),
                ),
                //NOTE::TEXTFIELD
                const SizedBox(
                  height: 24,
                ),
                Container(
                  padding: const EdgeInsets.only(left: 16),
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: const [
                        BoxShadow(
                            color: Color(0x40000000),
                            offset: Offset(0, 1),
                            blurRadius: 4,
                            spreadRadius: 0)
                      ],
                      color: whiteColor),
                  width: MediaQuery.of(context).size.width,
                  child: TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Email ',
                        hintStyle: lightTextStyle.copyWith(
                            fontSize: 15, color: greyLightColor),
                      )),
                ),
                const SizedBox(
                  height: 24,
                ),

                Container(
                  padding: const EdgeInsets.only(left: 16),
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: const [
                        BoxShadow(
                            color: Color(0x40000000),
                            offset: Offset(0, 1),
                            blurRadius: 4,
                            spreadRadius: 0)
                      ],
                      color: whiteColor),
                  width: MediaQuery.of(context).size.width,
                  child: TextField(
                      controller: passwordController,
                      obscureText: _secureText,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          onPressed: showHide,
                          icon: _secureText
                              ? const Icon(Icons.visibility_off, size: 20)
                              : const Icon(Icons.visibility, size: 20),
                        ),
                        border: InputBorder.none,
                        hintText: 'Password',
                        hintStyle: lightTextStyle.copyWith(
                            fontSize: 15, color: greyLightColor),
                      )),
                ),
                const SizedBox(
                  height: 30,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: ButtonPrimary(
                    text: "L O G I N ",
                    onTap: () {
                      if (emailController.text.isEmpty ||
                          passwordController.text.isEmpty) {
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                  title: const Text("Warning !!"),
                                  content:
                                      const Text("Please,enter the fields"),
                                  actions: [
                                    TextButton(
                                        onPressed: () {},
                                        child: const Text("ok"))
                                  ],
                                ));
                      } else {
                        loginsubmit(context);
                      }
                    },
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Dont have an account ?",
                      style: lightTextStyle.copyWith(
                          color: greyLightColor, fontSize: 15),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const RegisterPages(),
                          ),
                          (route) => false,
                        );
                      },
                      child: Text(
                        "Create Now",
                        style: boldTextStyle.copyWith(
                            color: greenColor, fontSize: 15),
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
