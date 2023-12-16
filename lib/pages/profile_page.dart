import 'package:flutter/material.dart';
import 'package:medhealth/network/model/pref_profile_model.dart';
import 'package:medhealth/pages/login_page.dart';
import 'package:medhealth/theme.dart';

import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late String fullName, createdDate, phone, email, address;

  getPref() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      fullName = sharedPreferences.getString(PrefProfile.name)!;
      createdDate = sharedPreferences.getString(PrefProfile.createdAt)!;
      phone = sharedPreferences.getString(PrefProfile.phone)!;
      email = sharedPreferences.getString(PrefProfile.email)!;
      address = sharedPreferences.getString(PrefProfile.address)!;
    });
  }

  @override
  void initState() {
    super.initState();
    getPref();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Profile Page'),
      // ),
      body: ListView(children: [
        Container(
          padding: EdgeInsets.all(24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "My Profile",
                style: regularTextStyle.copyWith(fontSize: 25),
              ),
              InkWell(
                onTap: () {
                  AuthUtils.clearPrefs();
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginPage(),
                      ),
                      (route) => false);
                },
                child: Icon(
                  Icons.exit_to_app,
                  color: greenColor,
                ),
              )
            ],
          ),
        ),
        // SizedBox(
        //   height: 20,
        // ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                fullName,
                style: boldTextStyle.copyWith(fontSize: 18),
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                "Join at" + createdDate,
                style: lightTextStyle,
              )
            ],
          ),
        ),
        //////////////////
        SizedBox(
          height: 20,
        ),
        Container(
          color: whiteColor,
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Phone Number",
                style: lightTextStyle,
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                phone,
                style: boldTextStyle.copyWith(fontSize: 18),
              )
            ],
          ),
        ),

        SizedBox(
          height: 20,
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Email",
                style: lightTextStyle,
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                email,
                style: boldTextStyle.copyWith(fontSize: 18),
              )
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Container(
          color: whiteColor,
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Address",
                style: lightTextStyle,
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                address,
                style: boldTextStyle.copyWith(fontSize: 18),
              )
            ],
          ),
        ),
        // ElevatedButton(
        //   onPressed: () async {
        //     AuthUtils.clearPrefs();
        //     Navigator.pushAndRemoveUntil(
        //         context,
        //         MaterialPageRoute(
        //           builder: (context) => LoginPage(),
        //         ),
        //         (route) => false);
        //   },
        //   child: Text('Logout'),
        // ),
      ]),
    );
  }
}

class AuthUtils {
  static const String isLoggedInKey = 'isLoggedIn';

  // Set the login status in SharedPreferences
  static Future<void> setLoggedIn(bool value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setBool(isLoggedInKey, value);
  }

  // Check if the user is logged in
  static Future<bool> isLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(isLoggedInKey) ?? false;
  }

  static Future<void> clearPrefs() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.clear();
  }

  // Perform logout
  static Future<void> logout() async {
    await setLoggedIn(false);
    // Add any additional logout logic here
  }
}
