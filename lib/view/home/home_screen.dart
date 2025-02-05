import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sobhanak_/controller/home_controller.dart';
import 'package:sobhanak_/view/home/widgets/home_main_theker_widget.dart';
import 'package:sobhanak_/view/home/widgets/home_side_bar_widget.dart';

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
              Obx(() => Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.fill,
                          image: controller.isLightTheme.value
                              ? const AssetImage(
                                  'assets/images/light.jpg')
                              : const AssetImage('assets/images/dark.jpg'))),
                  width: double.infinity)),
              Container(
                  color: Colors.black.withValues(alpha: 0.3),
                  width: double.infinity,
                  height: double.infinity),
              HomeMainThekerWidget(),
              Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 18.0, vertical: 30),
                      child: InkWell(
                          onTap: () => controller.showSidebar.toggle(),
                          child: Container(
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  color: Colors.black.withValues(alpha: 0.3),
                                  shape: BoxShape.circle),
                              child: const Icon(Icons.arrow_back,
                                  color: Colors.white))))),
              Obx(() {
                return AnimatedPositioned(
                    duration: const Duration(milliseconds: 700),
                    curve: Curves.easeInOut,
                    left: controller.showSidebar.value ? 0 : -250,
                    top: 0,
                    bottom: 0,
                    child: const HomeSideBarWidget());
              })
            ])));
  }
}
