import 'package:flutter/material.dart';
import 'package:medhealth/pages/splash_screen.dart';
import 'package:medhealth/pages/success_checkout.dart';
import 'package:medhealth/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: greenColor,
      ),
      debugShowCheckedModeBanner: false,
      // home: MainPage(),
      //  home: LoginPage(),
      home: const SplashScreen(),
      //     home: SuccessCheckout(),
    );
  }
}
