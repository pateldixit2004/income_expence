import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:income_expence/screen/view/home_screen.dart';
import 'package:income_expence/screen/view/income_screen.dart';
void main()
{
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/':(p0) => HomeScreen(),
        '/income':(p0) => IncomeScreen(),
      },
    )
  );
}