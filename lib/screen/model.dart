import 'dart:typed_data';

class IncomeModel
{
  int?  amount,id;
  String? note,date;
  Uint8List? imgUnit;

  IncomeModel({this.id,this.amount, this.note,this.imgUnit,this.date});
}

