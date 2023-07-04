import 'package:flutter/material.dart';
import 'package:get/get.dart';
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Income"),
          actions: [
            IconButton(onPressed: () async {

              DateTime? picker=await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(2000), lastDate: DateTime(2050));
              controller.datetime.value=controller.setDateFormat(picker!);

            }, icon: Icon(Icons.calendar_month),),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              buildTextField(
                  hint: "Amount",
                  inputype: TextInputType.number,
                  controller: txtamount),
              buildTextField(
                  hint: "notes",
                  inputype: TextInputType.text,
                  controller: txtnotes),
              ElevatedButton(
                onPressed: () {
                  IncomeModel model = IncomeModel(
                      amount: int.parse(txtamount.text), note: txtnotes.text);
                  DBhelper.dBhelper.insertdb(model: model);
                  controller.getData();
                  Get.back();
                },
                child: Text("Sumit"),
              ),
            ],
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
