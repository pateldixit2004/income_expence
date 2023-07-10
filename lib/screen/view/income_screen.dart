import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:income_expence/screen/model.dart';
import 'package:income_expence/utils/db_helper.dart';

import '../controller/income_controller.dart';

class IncomeScreen extends StatefulWidget {
  const IncomeScreen({Key? key}) : super(key: key);

  @override
  State<IncomeScreen> createState() => _IncomeScreenState();
}

class _IncomeScreenState extends State<IncomeScreen> {
  TextEditingController txtamount = TextEditingController();
  TextEditingController txtnotes = TextEditingController();
  Incomecontroller controller = Get.put(Incomecontroller());
  String selct = 'Income';

  Map m1 = {};

  @override
  void initState() {
    super.initState();
    m1 = Get.arguments;
    controller.imgPath!.value = "";
    if (m1['option'] == 0) {
      int index = m1['index'];
      txtamount = TextEditingController(
          text: "${controller.dataList[index]['amount']}");
      txtnotes =
          TextEditingController(text: controller.dataList[index]['note']);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor:  Color(0xff429690),
          title: Text(m1["option"] == 0 ? "update" : "Income"),
          actions: [
            IconButton(
              onPressed: () async {
                DateTime? picker = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2050));
                // controller.datetime.value = picker as String;
                controller.datetime.value=controller.setDateFormat(picker!);
              },
              icon: Icon(Icons.calendar_month),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [

                /*image*/
                // Obx(
                //   () => controller.imgPath!.isNotEmpty
                //       ? CircleAvatar(
                //           radius: 50,
                //           backgroundImage:
                //               FileImage(File("${controller.imgPath!.value}")),
                //         )
                //       : m1["option"] == 0
                //           ? CircleAvatar(
                //               radius: 50,
                //               backgroundImage: MemoryImage(
                //                   controller.dataList[m1['index']]['img']),
                //             )
                //           : CircleAvatar(
                //               radius: 50,
                //               backgroundImage: FileImage(
                //                   File("${controller.imgPath!.value}")),
                //             ),
                // ),
                /*icon*/
                // IconButton(
                //     onPressed: () async {
                //       ImagePicker picker = ImagePicker();
                //       XFile? xfile = await picker.pickImage(
                //           source: ImageSource.camera, imageQuality: 20);
                //       controller.imgUnit = await xfile!.readAsBytes();
                //
                //       controller.imgPath!.value = xfile.path;
                //     },
                //     icon: Icon(Icons.camera)),

                /*DAte in contenaier*/
                // Container(
                //   height: 100,
                //   width: 100,
                //   child: ElevatedButton(
                //       onPressed: () async {
                //         DateTime? picker = await showDatePicker(
                //             context: context,
                //             initialDate: DateTime.now(),
                //             firstDate: DateTime(2000),
                //             lastDate: DateTime(2050));
                //         // controller.datetime.value = picker as String;
                //         controller.datetime.value=controller.setDateFormat(picker!);
                //         // controller.dateTime.value =
                //         //     controller.setDateFormat(picker!);
                //       },
                //       child: Obx(() => Text("${controller.datetime.value}"))),
                // ),

                buildTextField(
                    hint: "Amount",
                    inputype: TextInputType.number,
                    controller: txtamount),
                SizedBox(
                  height: 10,
                ),
                buildTextField(
                    hint: "notes",
                    inputype: TextInputType.text,
                    controller: txtnotes),
                SizedBox(
                  height: 10,
                ),
                ListTile(leading: Text("Date",style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.bold)),),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () async {
                        DateTime? picker = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2050));
                        // controller.datetime.value = picker as String;
                        controller.datetime.value=controller.setDateFormat(picker!);
                      },
                      icon: Icon(Icons.calendar_month),
                    ),
                    Obx(() =>  Text("${controller.datetime.value}")),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                ListTile(leading: Text("Time",style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.bold)),),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () async {
                        TimeOfDay? t1=await showTimePicker(context: context, initialTime: TimeOfDay.now());
                        controller.changetime(t1!);
                      },
                      icon: Icon(Icons.watch_later_outlined),
                    ),
                    Text("${controller.timeOfDay}"),
                  ],
                ),
                ListTile(leading: Text("Staus",style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.bold),),),

                Obx(
                  () => RadioListTile(
                    value: "Income",
                    groupValue: controller.selctExpance.value,
                    onChanged: (value) {
                      // controller.changeIncome(value!);
                      controller.selctExpance.value = value!;
                    },
                    title: Text("Income"),
                  ),
                ),
                Obx(
                  () => RadioListTile(
                    value: "Expance",
                    groupValue: controller.selctExpance.value,
                    onChanged: (value) {
                      controller.selctExpance.value = value!;
                      // controller.changeIncome(value!);
                    },
                    title: Text("expance"),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (m1["option"] == 0) {

                      if(controller.imgPath!.value.isEmpty)
                        {
                          controller.imgUnit = controller.dataList[m1['index']]['img'];
                        }

                      IncomeModel model = IncomeModel(
                        id: controller.dataList[m1['index']]['id'],
                        amount: int.parse(txtamount.text),
                        note: txtnotes.text,
                        date: controller.datetime.value,
                        time: "${controller.timeOfDay}",
                        status: controller.selctExpance.value,
                        imgUnit: controller.imgUnit,
                      );
                      DBhelper.dBhelper.update(model);
                    } else {
                      IncomeModel model = IncomeModel(
                          amount: int.parse(txtamount.text),
                          note: txtnotes.text,
                          // date: "${controller.postDate}",
                          status: controller.selctExpance.value,
                          time: "${controller.timeOfDay}",
                          date: controller.datetime.value,
                          imgUnit: controller.imgUnit);
                      DBhelper.dBhelper.insertdb(model: model);
                    }
                    // print("hello");
                    controller.getData();
                    Get.back();
                  },
                  child: Text("Sumit"),style: ElevatedButton.styleFrom(backgroundColor:   Color(0xff429690),),
                ),

                // Container(
                //   height: 200,
                //   child: Column(
                //     children: [
                //       RadioListTile(
                //         value: "Income",
                //         groupValue: selct,
                //         onChanged: (value) {
                //           setState(() {
                //             selct = value!;
                //           });
                //         },
                //         title: Text("Income"),
                //       ),
                //       ListTile(
                //         title: Text("Expance/income"),
                //       ),
                //       // Obx(
                //       //       () =>
                //       //       DropdownButton(
                //       //         value: controller.selctExpance,
                //       //         items: controller.expanceList.map((element) =>
                //       //             DropdownMenuItem(child: Center(
                //       //               child: Text("$element"),), value: element,),),
                //       //         onChanged: (value) {
                //       //           controller.selctExpance.value = value! as String;
                //       //         },),
                //       // ),
                //
                //       Obx(
                //         () =>  DropdownButton(
                //             items: controller.expanceList.value.map((e) =>
                //                 DropdownMenuItem(child: Center(child: Text("$e"),),
                //                   value: e,)).toList(),
                //             value: controller.selctExpance,
                //             onChanged: (value) {
                //               controller.selctExpance!.value=value as String;
                //             },),
                //       ),
                //
                //       RadioListTile(
                //         value: "Expance",
                //         groupValue: selct,
                //         onChanged: (value) {
                //           setState(() {
                //             selct = value!;
                //           });
                //         },
                //         title: Text("Expance"),
                //       ),
                //
                //     ],
                //   ),
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }

  TextField buildTextField({hint, inputype, controller}) {
    return TextField(
      controller: controller,
      keyboardType: inputype,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: "$hint",
        label: Text("$hint"),
      ),
    );
  }
}
