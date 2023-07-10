import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:income_expence/screen/controller/income_controller.dart';
import 'package:income_expence/utils/db_helper.dart';
import 'package:sizer/sizer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Incomecontroller controller = Get.put(Incomecontroller());

  @override
  void initState() {
    super.initState();
    controller.getData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff429690),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 50,
                    width: 45.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7),
                      color: Colors.green,
                    ),
                    child: Center(child: Text("income")),
                  ),
                  SizedBox(
                    width: 2.w,
                  ),
                  Container(
                    height: 50,
                    width: 45.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7),
                      color: Colors.red,
                    ),
                    child: Center(child: Text("Exoance")),
                  )
                ],
              ),
            ),
            ListTile(
              leading: Text("Transaction history",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold)),
              trailing: Text(
                "see all",
                style: TextStyle(fontSize: 15),
              ),
            ),
            Obx(
              () => Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onDoubleTap: () {
                        DBhelper.dBhelper
                            .delete(controller.dataList[index]['id']);
                        controller.getData();
                      },
                      onLongPress: () {
                        Get.toNamed("/income",
                            arguments: {"option": 0, "index": index});
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          // leading: CircleAvatar(
                          //   radius: 50,
                          //   backgroundImage:
                          //       MemoryImage(controller.dataList[index]['img']),
                          // ),
                          title: Text("${controller.dataList[index]['note']}"),
                          // leading: Text(
                          //   controller.dataList[index]['status'],
                          //   style: TextStyle(
                          //       color: controller.dataList[index]['status'] ==
                          //               "Income"
                          //           ? Colors.green
                          //           : Colors.red),
                          // ),
                          subtitle:
                              Text("${controller.dataList[index]['data']}"),
                          trailing:
                              Text("₹ ${controller.dataList[index]['amount']}", style: TextStyle(
                        color: controller.dataList[index]['status'] ==
                                "Income"
                            ? Colors.green
                            : Colors.red,fontWeight: FontWeight.bold),
                        ),
                        ),
                      )
                    );
                  },
                  itemCount: controller.dataList.length,
                ),
              ),
            ),
          ],
        ),
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () {
        //     Get.toNamed("/income", arguments: {"option": 1, "index": null});
        //   },
        //   child: Icon(Icons.add),
        // ),
      ),
    );
  }
}
