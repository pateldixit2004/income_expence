import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:income_expence/screen/controller/income_controller.dart';
import 'package:income_expence/screen/model.dart';
import 'package:income_expence/utils/db_helper.dart';

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
          return GestureDetector(
            onDoubleTap: () {
              DBhelper.dBhelper.delete(controller.dataList[index]['id']);
              controller.getData();


            },
            onLongPress: () {
              Get.toNamed("/income",arguments: {"option":0,"index":index});
            },
            child: ListTile(
              title:  Text("${controller.dataList[index]['note']}"),
              trailing:  Text("${controller.dataList[index]['amount']}"),

            ),
          );

        },itemCount: controller.dataList.length,),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        Get.toNamed("/income",arguments: {"option":1,"index":null});
      },child: Icon(Icons.add),),
    ),);
  }
}
