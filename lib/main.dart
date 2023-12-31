import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:income_expence/screen/view/bottom_screen.dart';
import 'package:income_expence/screen/view/home_screen.dart';
import 'package:income_expence/screen/view/income_screen.dart';
import 'package:sizer/sizer.dart';
void main()
{
  runApp(
    Sizer(
      builder: (context, orientation, deviceType) =>  GetMaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: "/",
        routes: {
          '/':(p0) => BottomSheetScreen(),
          '/home':(p0) => HomeScreen(),
          '/income':(p0) => IncomeScreen(),
        },
      ),
    )
  );
}