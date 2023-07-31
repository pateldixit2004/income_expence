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
  TextEditingController txtfiler=TextEditingController();
  Map m1 = {};
  var sum;

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
          actions: [
            // IconButton(onPressed: () {
            //   controller.getFiler(controller.dataList[m1[0]]['categery']);
            // }, icon: Icon(Icons.search_rounded))
          ],
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: txtfiler,

                decoration: InputDecoration(
                    suffixIcon: IconButton(
                        onPressed: () {
                          txtfiler.text.isEmpty?controller.getData():controller.getFiler(txtfiler.text);

                          // controller.getFiler(txtfiler.text);
                        },
                        icon: Icon(Icons.search_rounded))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 70,
                    width: 45.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7),
                      color: Colors.green,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Center(
                          child: Text("Income",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),),
                        ),
                        Text("10000"),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 2.w,
                  ),
                  Container(
                    height: 70,
                    width: 45.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7),
                      color: Colors.red,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Center(child: Text("Expance",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),)),
                        Text("2000"),
                      ],
                    ),
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
                        onDoubleTap: () {},
                        onLongPress: () {},
                        child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Container(
                                  // height: 70,
                                  width: 100.w,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "${controller.dataList[index]['categery']}-(${controller.dataList[index]['note']})",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            "₹ ${controller.dataList[index]['amount']}",
                                            style: TextStyle(
                                                color:
                                                    controller.dataList[index]
                                                                ['status'] ==
                                                            "Income"
                                                        ? Colors.green
                                                        : Colors.red,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                              "${controller.dataList[index]['data']}"),
                                          SizedBox(
                                            child: Row(
                                              children: [
                                                IconButton(
                                                    onPressed: () {
                                                      Get.toNamed("/income",
                                                          arguments: {
                                                            "option": 0,
                                                            "index": index
                                                          });
                                                    },
                                                    icon: Icon(Icons.update)),
                                                IconButton(
                                                    onPressed: () {
                                                      DBhelper.dBhelper.delete(
                                                          controller.dataList[
                                                              index]['id']);
                                                      controller.getData();
                                                    },
                                                    icon: Icon(
                                                        Icons.delete_outline))
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )));
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

  ListTile buildListTile(int index) {
    return ListTile(
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
      subtitle: Text("${controller.dataList[index]['categery']}"),
      trailing: Text(
        "₹ ${controller.dataList[index]['amount']}",
        style: TextStyle(
            color: controller.dataList[index]['status'] == "Income"
                ? Colors.green
                : Colors.red,
            fontWeight: FontWeight.bold),
      ),
      // trailing: controller.dataList[index]['status'] == 'Income' ? Row(
      //         children: [
      //           Icon(Icons.add),
      //           Text(
      //             "${controller.dataList[index]['amount']}",
      //             style: TextStyle(
      //                 color: controller.dataList[index]
      //                             ['status'] ==
      //                         "Income"
      //                     ? Colors.lightGreen
      //                     : Colors.redAccent),
      //           )
      //         ],
      //       ) : Row(
      //         children: [
      //           Icon(Icons.minimize),
      //           Text(
      //             "${controller.dataList[index]['amount']}",
      //             style: TextStyle(
      //                 color: controller.dataList[index]
      //                             ['status'] ==
      //                         "Income"
      //                     ? Colors.lightGreen
      //                     : Colors.redAccent),
      //           )
      //         ],
      //       ),
    );
  }
}
