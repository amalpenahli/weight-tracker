import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:getx/screen/add_record.dart';
import 'package:provider/provider.dart';

import 'package:syncfusion_flutter_charts/charts.dart';

import '../provider/provider.dart';
import '../widgets/rich_text.dart';
import '../widgets/top_graphic_info.dart';

class FlutterChart extends StatefulWidget {
  const FlutterChart({Key? key}) : super(key: key);

  @override
  State<FlutterChart> createState() => _FlutterChartState();
}

class _FlutterChartState extends State<FlutterChart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Qrafika"),
         
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, 
          children: [
              StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection("tracker")
                .where("userId",
                    isEqualTo: Provider.of<ProviderProfile>(context,
                            listen: false)
                        .checkUser())
                .snapshots(),
            builder: (context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Text("error");
              }

              return Column(
                children: [
                  Row(
          children: [
            Row(
              children: const [
                TopGraphicInfo(color: Colors.red, text: "artiq ceki"),
                TopGraphicInfo(color: Colors.blue, text: "asagi ceki"),
              ],
            ),
          ],
              ),
                  SfCartesianChart(

                      // Enable tooltip
                      tooltipBehavior: TooltipBehavior(enable: true),
                      primaryXAxis: CategoryAxis(
                        majorGridLines: const MajorGridLines(
                            width: 0.7,
                            color: Colors.white,
                            dashArray: <double>[5, 5]),
                        axisLine: const AxisLine(
                            color: Colors.grey,
                            width: 0.7,
                            dashArray: <double>[5, 5]),
                        opposedPosition: false,
                      ),
                      primaryYAxis: CategoryAxis(
                          axisLine: const AxisLine(
                              color: Colors.white,
                              width: 0,
                              dashArray: <double>[5, 5]),
                          majorGridLines: const MajorGridLines(
                              width: 0.7,
                              color: Colors.grey,
                              dashArray: <double>[5, 5]),
                          minimum: 40,
                          maximum: 140,
                          interval: 10,
                          opposedPosition: true),
                      series: <ChartSeries<dynamic, String>>[
                        SplineSeries<dynamic, String>(
                            dataSource: snapshot.data.docs,
                            xValueMapper: (dynamic sales, _) =>
                                sales["month"],
                            yValueMapper: (dynamic sales, _) =>
                                int.tryParse(sales["weight"]),
                            color: Colors.orange,
                            dataLabelSettings:
                                DataLabelSettings(isVisible: true)),
                      ]),
                 
                ],
              );
            }),
              
              ElevatedButton(
            onPressed: () {
              Get.to(() => AddRecord());
            },
            child: Text("add record"))
            ]),
        ));
  }
}

class Weight {
  Weight(this.month, this.weight);

  final String month;
  final double weight;
}
