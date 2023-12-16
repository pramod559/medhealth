// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:medhealth/network/model/pref_profile_model.dart';
import 'package:medhealth/pages/login_page.dart';
import 'package:medhealth/pages/main_page.dart';
import 'package:medhealth/widget/button_primary.dart';
import 'package:medhealth/widget/general_logo_space.dart';
import 'package:medhealth/widget/widget_ilustration.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late String userID;
  getPref() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      userID = sharedPreferences.getString(PrefProfile.idUser)!;
      userID == null ? sessionLogout() : sessionLogin();
    });
  }

  sessionLogout() {}
  sessionLogin() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const MainPage()));
  }

  @override
  void initState() {
    //ignore: todo
    // TODO: implement initState
    super.initState();
    getPref();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GeneralLogoSpace(
          child: Column(
        children: [
          // SizedBox(
          //   height: 45,
          // ),
          WidgetIlustration(
            image: "assets/splash_ilustration.png",
            title: "Find your medical\nsolution",
            subtitle1: "Consult with a doctor",
            subtitle2: "whereever and whenever you want",
            child: ButtonPrimary(
              text: "GET STARTED",
              onTap: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginPage(),
                    ));
              },
            ),
          )
        ],
      )),
    );
  }
}
