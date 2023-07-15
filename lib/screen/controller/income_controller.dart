 import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:income_expence/screen/view/chat-screen.dart';
import 'package:income_expence/screen/view/home_screen.dart';
import 'package:income_expence/screen/view/income_screen.dart';
import 'package:income_expence/screen/view/line_chart.dart';
import 'package:income_expence/screen/view/other_chart.dart';
import 'package:income_expence/utils/db_helper.dart';
import 'package:intl/intl.dart';


class Incomecontroller extends GetxController
{
  RxList dataList=[].obs;
  RxInt indexbottom=0.obs;
  RxDouble sum=0.0.obs;


  List screenList=[
    HomeScreen(),
    ChatScreen(),
    LineChatScreen(),
    OtherChatScreen(),
  ];

  RxString? imgPath="".obs;
  Uint8List  imgUnit=Uint8List(10);

  Future<void> getData()
  async {
    dataList.value =await DBhelper.dBhelper.readDb();
  }


  RxString datetime ="${DateTime.now()}".obs;
  RxString postDate=''.obs;
  void post(String dataTime)
  {
    postDate=dataTime.obs;
  }


  String setDateFormat(DateTime dm)
  {
    var f = DateFormat("dd-MM-yyyy");
    return f.format(dm);
  }

  TimeOfDay timeOfDay=TimeOfDay.now();
  void changetime(TimeOfDay t1)
  {
    timeOfDay=t1;
    update();
  }


  RxString inves="Food".obs;
  RxList<String> expanceList=[
    'Education',"Food","Home maintance","Salary","Investment"
  ].obs;




  RxString selctExpance="Income".obs;


  Future<void> getFiler(String categery)
  async {
    dataList.value=await  DBhelper.dBhelper.filer(categery);
  }

  void changeIncome()
  {

  }
}