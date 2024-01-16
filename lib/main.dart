// ignore_for_file: unused_import

import 'package:covid_tracker/Services/Utilities/route.dart';
import 'package:covid_tracker/Services/Utilities/routes_name.dart';
import 'package:covid_tracker/View/splash_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
      ),
      initialRoute: RouteName.splashSceen,
      onGenerateRoute: Routes.generateRoute,
    );
  }
}
