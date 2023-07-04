import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:income_expence/screen/model.dart';
import 'package:income_expence/utils/db_helper.dart';

class IncomeScreen extends StatefulWidget {
  const IncomeScreen({Key? key}) : super(key: key);

  @override
  State<IncomeScreen> createState() => _IncomeScreenState();
}

class _IncomeScreenState extends State<IncomeScreen> {
  TextEditingController txtamount=TextEditingController();
  TextEditingController txtnotes=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar: AppBar(
        title: Text("Income"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            buildTextField(hint: "Amount",inputype: TextInputType.number,controller: txtamount),
            buildTextField(hint: "notes",inputype: TextInputType.text,controller: txtnotes),
            ElevatedButton(onPressed: () {
              IncomeModel model=IncomeModel(amount: int.parse(txtamount.text),note: txtnotes.text);
              DBhelper.dBhelper.insertdb(model: model);
              Get.back();
            }, child: Text("Sumit"))

          ],
        ),
      ),
    ),);
  }

  TextField buildTextField({hint,inputype,controller}) {
    return TextField(
      controller: controller,
      keyboardType:inputype ,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: "$hint",
            label: Text("$hint"),
          ),
        );
  }
}
