// ignore_for_file: unused_import

import 'dart:async';

import 'package:covid_tracker/Services/Utilities/routes_name.dart';
import 'package:covid_tracker/Services/stats_services.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import 'details_screen.dart';

class CountriesListScreen extends StatefulWidget {
  const CountriesListScreen({super.key});

  @override
  State<CountriesListScreen> createState() => _CountriesListScreenState();
}

class _CountriesListScreenState extends State<CountriesListScreen> {
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    StatsServices statsServices = StatsServices();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                onChanged: (value) {
                  setState(() {});
                },
                controller: searchController,
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                    hintText: 'Search with country name',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50))),
              ),
            ),
            Expanded(
              child: FutureBuilder(
                future: statsServices.countriesListApi(),
                builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                  if (!snapshot.hasData) {
                    return ListView.builder(
                        itemCount: 8,
                        itemBuilder: (context, index) {
                          return Shimmer.fromColors(
                            baseColor: Colors.grey.shade700,
                            highlightColor: Colors.grey.shade100,
                            child: Column(
                              children: [
                                ListTile(
                                  title: Container(
                                    height: 10,
                                    width: 80,
                                    color: Colors.white,
                                  ),
                                  subtitle: Container(
                                    height: 10,
                                    width: 80,
                                    color: Colors.white,
                                  ),
                                  leading: Container(
                                    height: 50,
                                    width: 50,
                                    color: Colors.white,
                                  ),
                                )
                              ],
                            ),
                          );
                        });
                  } else {
                    return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          String name = snapshot.data![index]['country'];

                          if (searchController.text.isEmpty) {
                            return Column(
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, RouteName.detailScreen,
                                        arguments: {
                                          'name': snapshot.data![index]
                                                  ['country']
                                              .toString(),
                                          'totalDeaths': snapshot.data![index]
                                              ['deaths'],
                                          'image': snapshot.data![index]
                                                  ['countryInfo']['flag']
                                              .toString(),
                                          'totalCases': snapshot.data![index]
                                              ['cases'],
                                          'test': snapshot.data![index]
                                              ['tests'],
                                          'todayRecovered': snapshot
                                              .data![index]['todayRecovered'],
                                          'totalRecovered': snapshot
                                              .data![index]['recovered'],
                                          'active': snapshot.data![index]
                                              ['active'],
                                          'critical': snapshot.data![index]
                                              ['critical'],
                                        });
                                  },
                                  child: ListTile(
                                    title:
                                        Text(snapshot.data![index]['country']),
                                    subtitle: Text(snapshot.data![index]
                                            ['cases']
                                        .toString()),
                                    leading: Image(
                                      height: 50,
                                      width: 50,
                                      image: NetworkImage(snapshot.data![index]
                                          ['countryInfo']['flag']),
                                    ),
                                  ),
                                )
                              ],
                            );
                          } else if (name
                              .toLowerCase()
                              .contains(searchController.text.toLowerCase())) {
                            return Column(
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, RouteName.detailScreen,
                                        arguments: {
                                          'name': snapshot.data![index]
                                                  ['country']
                                              .toString(),
                                          'totalDeaths': snapshot.data![index]
                                              ['deaths'],
                                          'image': snapshot.data![index]
                                                  ['countryInfo']['flag']
                                              .toString(),
                                          'totalCases': snapshot.data![index]
                                              ['cases'],
                                          'test': snapshot.data![index]
                                              ['tests'],
                                          'todayRecovered': snapshot
                                              .data![index]['todayRecovered'],
                                          'totalRecovered': snapshot
                                              .data![index]['recovered'],
                                          'active': snapshot.data![index]
                                              ['active'],
                                          'critical': snapshot.data![index]
                                              ['critical'],
                                        });
                                  },
                                  child: ListTile(
                                    title:
                                        Text(snapshot.data![index]['country']),
                                    subtitle: Text(snapshot.data![index]
                                            ['cases']
                                        .toString()),
                                    leading: Image(
                                      height: 50,
                                      width: 50,
                                      image: NetworkImage(snapshot.data![index]
                                          ['countryInfo']['flag']),
                                    ),
                                  ),
                                )
                              ],
                            );
                          } else {
                            return Container();
                          }
                        });
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
