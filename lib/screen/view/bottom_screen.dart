import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:income_expence/screen/controller/income_controller.dart';

class BottomSheetScreen extends StatefulWidget {
  const BottomSheetScreen({Key? key}) : super(key: key);

  @override
  State<BottomSheetScreen> createState() => _BottomSheetScreenState();
}

class _BottomSheetScreenState extends State<BottomSheetScreen> {
  Incomecontroller controller = Get.put(Incomecontroller());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Obx(() =>  controller.screenList[controller.indexbottom.value]),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.toNamed("/income",arguments: {"option": 1, "index": null});

          },
          backgroundColor: Color(0xff429690),
          child: const Icon(
            Icons.add,
          ),
        ),
        floatingActionButtonLocation:
            FloatingActionButtonLocation.miniCenterDocked,
        bottomNavigationBar: BottomAppBar(
          color: Color(0xff429690),
          notchMargin: 5,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(
                  Icons.home,
                  color: Colors.white,
                ),
                onPressed: () {
                 controller.indexbottom.value =0;

                },
              ),
              IconButton(
                icon: const Icon(
                  Icons.bar_chart,
                  color: Colors.white,
                ),
                onPressed: () {
                  controller.indexbottom.value =1;

                },
              ),
              IconButton(
                icon: const Icon(
                  Icons.messenger_outline,
                  color: Colors.white,
                ),
                onPressed: () {
                  controller.indexbottom.value =2;

                },
              ),
              IconButton(
                icon: const Icon(
                  Icons.person,
                  color: Colors.white,
                ),
                onPressed: () {
                  controller.indexbottom.value =3;

                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
