import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:income_expence/screen/controller/income_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Incomecontroller controller =Get.put(Incomecontroller());
  @override
  void initState() {

    super.initState();
    controller.getData();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body: Obx(
        () =>  ListView.builder(itemBuilder: (context, index) {
          // return ListTile(
          //   title:  Text("${controller.dataList[index]['note']}"),
          //   trailing:  Text("${controller.dataList[index]['amount']}"),
          //
          // );

        },itemCount: controller.dataList.length,),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        Get.toNamed("/income");
      },child: Icon(Icons.add),),
    ),);
  }
}
