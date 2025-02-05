import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sobhanak_/controller/home_controller.dart';
import 'package:sobhanak_/view/athkar/athkar_screen.dart';
import 'package:sobhanak_/view/home/model/home_model.dart';

class HomeSideBarWidget extends StatelessWidget {
  const HomeSideBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeControllerImp controller = Get.put(HomeControllerImp());
    return Align(
        alignment: Alignment.center,
        child: Container(
            margin: const EdgeInsets.only(left: 13),
            alignment: Alignment.center,
            width: 50,
            height: 400,
            child: ListView.separated(
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 13),
                itemCount: homeModelList.length,
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return Obx(() => InkWell(
                        onTap: () => controller.toggleTheme(),
                        child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                                color: controller.isLightTheme.value
                                    ? Color.fromARGB(255, 193, 193, 193)
                                        .withValues(alpha: .7)
                                    : Colors.black.withValues(alpha: .7),
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    color: Colors.black.withValues(alpha: .6),
                                    width: 1.5)),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                      controller.isLightTheme.value
                                          ? Icons.light_mode
                                          : Icons.dark_mode,
                                      color: controller.isLightTheme.value
                                          ? Colors.black
                                          : Colors.white),
                                  Text(
                                      controller.isLightTheme.value
                                          ? 'فاتح'
                                          : 'داكن',
                                      style: TextStyle(
                                          color: controller.isLightTheme.value
                                              ? Colors.black
                                              : Colors.white,
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold)),
                                  const SizedBox(height: 4)
                                ]))));
                  } else {
                    return Obx(() => InkWell(
                        onTap: () async {
                          if (index == homeModelList.length - 1) {
                            controller.openEmail();
                          } else if (index == 2) {
                            controller.isSoundEnabled.value =
                                !controller.isSoundEnabled.value;
                          } else if (index == 3) {
                            Get.to(() => const AthkarScreen(),
                                transition: Transition.leftToRight);
                          } else {
                            controller.remove();
                          }
                        },
                        child: Container(
                            alignment: Alignment.center,
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                                color: controller.isLightTheme.value
                                    ? const Color.fromARGB(255, 193, 193, 193)
                                        .withValues(alpha: .7)
                                    : Colors.black.withValues(alpha: .7),
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    color: Colors.black.withValues(alpha: .6),
                                    width: 1.5)),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  index == 2
                                      ? Obx(() => InkWell(
                                          onTap: () {
                                            controller.isSoundEnabled.value =
                                                !controller
                                                    .isSoundEnabled.value;
                                            if (controller
                                                .isSoundEnabled.value) {
                                              controller.add();
                                            } else {
                                              controller.player.stop();
                                            }
                                          },
                                          child: Icon(
                                              controller.isSoundEnabled.value
                                                  ? Icons.volume_up
                                                  : Icons.volume_off,
                                              size: 20,
                                              color:
                                                  controller.isLightTheme.value
                                                      ? Colors.black
                                                      : Colors.white)))
                                      : Obx(() => Icon(
                                          homeModelList[index].icon.icon,
                                          color: controller.isLightTheme.value
                                              ? Colors.black
                                              : Colors.white,
                                          size: 20)),
                                  Text(homeModelList[index].text,
                                      style: TextStyle(
                                          color: controller.isLightTheme.value
                                              ? Colors.black
                                              : Colors.white,
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold))
                                ]))));
                  }
                })));
  }
}
