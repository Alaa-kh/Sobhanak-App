import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sobhanak/controller/home_controller.dart';
import 'package:sobhanak/view/home/widgets/home_side_bar_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeControllerImp controller = Get.put(HomeControllerImp());
    return Scaffold(
        body: GestureDetector(
            onTap: () {
              controller.add();
            },
            child: Stack(children: [
          Obx(()=>    Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.fill,
                          image: controller.isLightTheme.value
                              ? AssetImage(
                                  'assets/images/luciano-zorro-xUbbrCLt9NY-unsplash.jpg')
                              : AssetImage(
                                  'assets/images/kate-mishchankova-Gb_fZjvaLxw-unsplash.jpg'))),
                  width: double.infinity)),
              Container(
                  color: Colors.black.withOpacity(0.3),
                  width: double.infinity,
                  height: double.infinity),
              Center(
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
                              fontSize: 40,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center))),
                    const SizedBox(height: 10),
                    Obx(() => Text(
                          '${controller.athkarCounts[controller.thekr.value] ?? 0}',
                          style: const TextStyle(
                              fontSize: 40, color: Colors.white),
                        ))
                  ])),
              const HomeSideBarWidget()
            ])));
  }
}
