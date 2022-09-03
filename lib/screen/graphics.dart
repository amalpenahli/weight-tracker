import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx/main.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

import '../views_model/controller.dart';

void main() {
  return runApp(MyApp());
}



class MyHomePage extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  MyHomePage( {Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
static Controller controller = Get.put(Controller());


  

  String year = "2022";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Qrafik'),
        ),
        body: GetBuilder<Controller>(
          init: Controller(),
          builder: (context) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
              //Initialize the chart widget
              SfCartesianChart(
                primaryYAxis: CategoryAxis(minimum: 15, maximum: 55),
                  primaryXAxis: CategoryAxis(),
                  // Chart title
                  title: ChartTitle(text: 'Arıqlama cədvəli'),
                  // Enable legend
                  legend: Legend(isVisible: false),
                  // Enable tooltip
                  tooltipBehavior: TooltipBehavior(enable: true),
                  series: <ChartSeries<Month, String>>[
                    LineSeries<Month, String>(
                        dataSource: controller.data,
                        xValueMapper: (Month weight, _) => weight.year,
                        yValueMapper: (Month weight, _) => weight.weight,
                       
                        // Enable data label
                        dataLabelSettings: DataLabelSettings(isVisible: true))
                  ]),
              
            ]);
          }
        ));
  }
}

class Month {
  Month(this.year, this.weight);

  final String year;
  final double weight;
}