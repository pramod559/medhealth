import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:medhealth/network/api/url_api.dart';
import 'package:medhealth/network/model/history_model.dart';
import 'package:medhealth/network/model/pref_profile_model.dart';
import 'package:medhealth/pages/card_history.dart';
import 'package:medhealth/theme.dart';
import 'package:medhealth/widget/widget_ilustration.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  List<HistoryOrderModel> list = [];
  late String userID;
  getPref() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      userID = sharedPreferences.getString(PrefProfile.idUser)!;
    });
    getHistory();
  }

  getHistory() async {
    list.clear();
    var urlHistory = Uri.parse(BASEURL.historyOrder + userID);
    final response = await http.get(urlHistory);
    if (response.statusCode == 200) {
      setState(() {
        final data = jsonDecode(response.body);
        for (Map<String, dynamic> item in data) {
          list.add(HistoryOrderModel.fromjson(item));

//          print(list[0].idUser);
        }
      });
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
        child: ListView(children: [
          Container(
            padding: EdgeInsets.fromLTRB(24, 24, 24, 0),
            height: 70,
            child: Text(
              "History Order",
              style: regularTextStyle.copyWith(fontSize: 25),
            ),
          ),
          SizedBox(height: (list.isEmpty) ? 80 : 20),
          list.length == 0
              ? Center(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    child: WidgetIlustration(
                      image: 'assets/no_history_ilustration.png',
                      title: "you don't have history order",
                      subtitle1: 'lets shopping now',
                      subtitle2: 'Oops ,there are no history order',
                    ),
                  ),
                )
              : ListView.builder(
                  shrinkWrap: true,
                  itemCount: list.length,
                  itemBuilder: (context, i) {
                    final x = list[i];

                    return Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                      child: CardHistory(
                        model: x,
                      ),
                    );
                  },
                ),
        ]),
      ),
    );
  }
}
