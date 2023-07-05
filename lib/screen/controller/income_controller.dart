 import 'dart:typed_data';

import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:income_expence/utils/db_helper.dart';

class Incomecontroller extends GetxController
{
  RxList dataList=[].obs;



  RxString? imgPath="".obs;
  Uint8List?  imgUnit;

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


  // String setDateFormat(DateTime dm)
  // {
  //   var f = DateFormat("dd-MM-yyyy");
  //   return f.format(dm);
  // }


  // RxString selct='Income'.obs

  RxList expanceList=[
    'Education',"Food","Home maintance","Salary","Investment"
  ].obs;

  RxString selctExpance="Income".obs;

}