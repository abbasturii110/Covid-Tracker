// ignore_for_file: must_be_immutable, use_key_in_widget_constructors, prefer_const_constructors, unused_local_variable, prefer_const_constructors_in_immutables

import 'package:covid_tracker/View/world_stats.dart';
import 'package:flutter/material.dart';

class DetailsScreen extends StatefulWidget {
  final Map<String, dynamic> data;

  DetailsScreen({required this.data});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    String name = widget.data['name'].toString();
    int totalCases = widget.data['totalCases'] as int;
    int totalDeaths = widget.data['totalDeaths'] as int;
    int test = widget.data['test'] as int;
    int active = widget.data['active'] as int;
    String image = widget.data['image'].toString();
    int todayRecovered = widget.data['todayRecovered'] as int;
    int totalRecovered = widget.data['totalRecovered'] as int;
    int critical = widget.data['critical'] as int;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(name),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.topCenter,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * .067),
                    child: Card(
                      child: Column(
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * .06,
                          ),
                          ReusableRow(
                              title: 'Cases', value: totalCases.toString()),
                          ReusableRow(
                              title: 'Recovered',
                              value: totalRecovered.toString()),
                          ReusableRow(
                              title: 'Deaths', value: totalDeaths.toString()),
                          ReusableRow(
                              title: 'Critical', value: critical.toString()),
                          ReusableRow(
                              title: 'Today Recovered',
                              value: todayRecovered.toString()),
                        ],
                      ),
                    ),
                  ),
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(image),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
