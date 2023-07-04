import 'package:get/get.dart';
import 'package:income_expence/utils/db_helper.dart';

class Incomecontroller extends GetxController
{
  RxList dataList=[].obs;
  Future<void> getData()
  async {
    dataList.value =await DBhelper.dBhelper.readDb();
  }
}