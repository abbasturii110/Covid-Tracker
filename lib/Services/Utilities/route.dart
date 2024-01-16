// ignore_for_file: prefer_const_constructors

import 'package:covid_tracker/Services/Utilities/routes_name.dart';
import 'package:covid_tracker/View/countries_list.dart';
import 'package:covid_tracker/View/details_screen.dart';
import 'package:covid_tracker/View/splash_screen.dart';
import 'package:covid_tracker/View/world_stats.dart';
import 'package:flutter/material.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteName.splashSceen:
        return MaterialPageRoute(builder: (context) => SplashScreen());
      case RouteName.worldStatsScreen:
        return MaterialPageRoute(builder: (context) => WorldStatsScreen());
      case RouteName.countriesListScreen:
        return MaterialPageRoute(builder: (context) => CountriesListScreen());
      case RouteName.detailScreen:
        return MaterialPageRoute(
            builder: (context) => DetailsScreen(
                  data: settings.arguments as Map<String, dynamic>,
                ));
      default:
        return MaterialPageRoute(builder: (context) {
          return const Scaffold(
            body: Center(child: Text('No route defined.')),
          );
        });
    }
  }
}
