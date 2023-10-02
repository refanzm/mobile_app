import 'package:flutter/material.dart';
import 'package:apps/constant/route_constants.dart';
import 'package:apps/pages/LoginPage.dart';
import 'package:apps/pages/HomePage.dart';
import 'package:apps/pages/DetailCashFlowPage.dart';
import 'package:apps/pages/SettingsPage.dart';
import 'package:apps/pages/OutcomePage.dart';
import 'package:apps/pages/IncomePage.dart';
import 'package:apps/providers/user_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => UserProvider()),
  ], child: const MyApp()));
}

final routes = {
  loginRoute: (BuildContext context) => LoginPage(),
  homeRoute: (BuildContext context) => HomePage(),
  settingsRoute: (BuildContext context) => SettingsPage(),
  addExpenseRoute: (BuildContext context) => AddExpenditurePage(),
  addIncomeRoute: (BuildContext context) => AddIncomePage(),
  detailCashFlowRoute: (BuildContext context) => DetailCashFlowPage(),
};

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "RM Apps",
      theme: ThemeData(primaryColor: Colors.green[200]),
      routes: routes,
    );
  }
}
