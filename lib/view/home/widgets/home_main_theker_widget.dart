import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sobhanak_/controller/home_controller.dart';

class HomeMainThekerWidget extends StatelessWidget {
  const HomeMainThekerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeControllerImp controller = Get.put(HomeControllerImp());

    return Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
          Obx(() => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Text(
                  controller.thekr.isNotEmpty
                      ? controller.thekr.value
                      : 'الحمد لله',
                  style: const TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center))),
          const SizedBox(height: 20),
          Obx(() => Text(
              '${controller.athkarCounts[controller.thekr.value] ?? 0}',
              style: const TextStyle(fontSize: 30, color: Colors.white)))
        ]));
  }
}
