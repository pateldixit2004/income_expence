import 'package:flutter/material.dart';
import 'package:income_expence/utils/db_helper.dart';

class IncomeScreen extends StatefulWidget {
  const IncomeScreen({Key? key}) : super(key: key);

  @override
  State<IncomeScreen> createState() => _IncomeScreenState();
}

class _IncomeScreenState extends State<IncomeScreen> {
  TextEditingController txtamount=TextEditingController();
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
            ElevatedButton(onPressed: () {
              DBhelper.dBhelper.insertdb(
                amount: int.parse(txtamount.text),
              );
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
