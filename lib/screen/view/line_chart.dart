import 'package:chart_sparkline/chart_sparkline.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:income_expence/screen/controller/income_controller.dart';

class LineChatScreen extends StatefulWidget {
  const LineChatScreen({Key? key}) : super(key: key);

  @override
  State<LineChatScreen> createState() => _LineChatScreenState();
}

class _LineChatScreenState extends State<LineChatScreen> {
  Incomecontroller controller = Get.put(Incomecontroller());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: Sparkline(
              data: [double.parse("${controller.dataList[2]['amount']}"),double.parse("${controller.dataList[2]['amount']}")],
            // backgroundColor: Colors.red,
            // lineColor: Colors.lightGreen[500]!,
            // fillMode: FillMode.below,
            // fillColor: Colors.lightGreen[200]!,
            // pointsMode: PointsMode.all,
            // pointSize: 5.0,
            // pointColor: Colors.amber,
            // useCubicSmoothing: true,
            // lineWidth: 1.0,
            // gridLinelabelPrefix: '\$',
            // gridLineLabelPrecision: 3,
            // enableGridLines: true,
            // averageLine: true,
            // averageLabel: true,
            kLine: ['max', 'min', 'first', 'last'],
            // max: 50.5,
            // min: 10.0,
            enableThreshold: true,
            thresholdSize: 0.1,
            // lineGradient: LinearGradient(
            //   begin: Alignment.topCenter,
            //   end: Alignment.bottomCenter,
            //   colors: [Colors.purple[800]!, Colors.purple[200]!],
            // ),
          //   fillGradient: LinearGradient(
          //     begin: Alignment.topCenter,
          //     end: Alignment.bottomCenter,
          //     // colors: [Colors.red[800]!, Colors.red[200]!],
          // ),
        ),
      ),
      )
    );
  }
}
