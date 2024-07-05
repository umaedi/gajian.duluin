import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class PieChartHistory extends StatefulWidget {
  final Map<String, double> dataMap;

  const PieChartHistory({super.key, required this.dataMap});

  @override
  State<PieChartHistory> createState() => _PieChartHistoryState();
}

class _PieChartHistoryState extends State<PieChartHistory> {
  List<Color> colorList = [
    const Color(0XFFD95AF3),
    const Color(0XFF3EE094),
    const Color(0XFF3339F6),
    const Color(0XFFaaaaaa),
    const Color(0XFFff9b9b),
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return PieChart(
      dataMap: widget.dataMap,
      colorList: colorList,
      chartRadius: size.width * 0.25,
      chartLegendSpacing: 10,
      legendOptions: LegendOptions(
          legendTextStyle: TextStyle(
        fontSize: size.width * 0.030,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      )),
      chartValuesOptions: ChartValuesOptions(
        showChartValues: true,
        showChartValuesInPercentage: true,
        showChartValuesOutside: false,
        showChartValueBackground: true,
        decimalPlaces: 0,
        chartValueStyle: TextStyle(
          fontSize: size.width * 0.025,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }
}
