// ignore_for_file: prefer_const_constructors

import 'package:covid_tracker/Model/WorldStatsModel.dart';
import 'package:covid_tracker/Services/Utilities/routes_name.dart';

import 'package:covid_tracker/Services/stats_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

class WorldStatsScreen extends StatefulWidget {
  const WorldStatsScreen({super.key});

  @override
  State<WorldStatsScreen> createState() => _WorldStatsScreenState();
}

class _WorldStatsScreenState extends State<WorldStatsScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(duration: const Duration(seconds: 3), vsync: this)
        ..repeat();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  final colorList = <Color>[
    const Color(0xff4285F4),
    const Color(0xff1aa260),
    const Color(0xffde5246),
  ];

  @override
  Widget build(BuildContext context) {
    StatsServices statsServices = StatsServices();
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * .01,
                ),
                FutureBuilder(
                    future: statsServices.fetchWorldStatsRecords(),
                    builder:
                        (context, AsyncSnapshot<WorldStatsModel> snapshot) {
                      if (!snapshot.hasData) {
                        return Expanded(
                          flex: 1,
                          child: SpinKitFadingCircle(
                            size: 50.0,
                            color: Colors.white,
                            controller: _controller,
                          ),
                        );
                      } else {
                        return Column(
                          children: [
                            PieChart(
                              dataMap: {
                                "Total": double.parse(
                                    snapshot.data!.cases.toString()),
                                "Recovered": double.parse(
                                    snapshot.data!.recovered.toString()),
                                "Death": double.parse(
                                    snapshot.data!.deaths.toString())
                              },
                              animationDuration:
                                  const Duration(milliseconds: 1200),
                              chartValuesOptions: ChartValuesOptions(
                                  showChartValuesInPercentage: true),
                              legendOptions: const LegendOptions(
                                legendPosition: LegendPosition.left,
                              ),
                              chartType: ChartType.ring,
                              colorList: colorList,
                              chartRadius:
                                  MediaQuery.of(context).size.width / 3.2,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical:
                                      MediaQuery.of(context).size.height * .06),
                              child: Card(
                                child: Column(
                                  children: [
                                    ReusableRow(
                                        title: 'Total',
                                        value: snapshot.data!.cases.toString()),
                                    ReusableRow(
                                        title: 'Recovered',
                                        value: snapshot.data!.recovered
                                            .toString()),
                                    ReusableRow(
                                        title: 'Death',
                                        value:
                                            snapshot.data!.deaths.toString()),
                                    ReusableRow(
                                        title: 'Active',
                                        value:
                                            snapshot.data!.active.toString()),
                                    ReusableRow(
                                        title: 'Critical',
                                        value:
                                            snapshot.data!.critical.toString()),
                                    ReusableRow(
                                        title: 'Today\'s Deaths',
                                        value: snapshot.data!.todayDeaths
                                            .toString()),
                                    ReusableRow(
                                        title: 'Today Recovered',
                                        value: snapshot.data!.todayRecovered
                                            .toString()),
                                  ],
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, RouteName.countriesListScreen);
                              },
                              child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                    color: const Color(0xff1aa260),
                                    borderRadius: BorderRadius.circular(10)),
                                child: const Center(
                                    child: Text('Track Countries')),
                              ),
                            )
                          ],
                        );
                      }
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ReusableRow extends StatelessWidget {
  final String title, value;
  const ReusableRow({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Text(value),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          const Divider(
            thickness: 1,
          )
        ],
      ),
    );
  }
}
