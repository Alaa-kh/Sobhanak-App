import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sobhanak/controller/home_controller.dart';
import 'package:sobhanak/view/home/athkar/athkar_screen.dart';
import 'package:sobhanak/view/home/model/home_model.dart';

class HomeSideBarWidget extends StatelessWidget {
  const HomeSideBarWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final HomeControllerImp controller = Get.put(HomeControllerImp());
    return Align(
        alignment: Alignment.bottomLeft,
        child: Obx(() {
          return Container(
              decoration: BoxDecoration(
                color: controller.isLightTheme.value
                    ? Color(0xff042c41).withOpacity(.5)
                    : Colors.black.withOpacity(.5),
                borderRadius: BorderRadius.circular(38),
              ),
              alignment: Alignment.center,
              width: 70,
              height: 400,
              child: ListView.separated(
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 20),
                itemCount: homeModelList.length,
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                itemBuilder: (context, index) => InkWell(
                  onTap: () {
                    if (index == 0) {
                      controller
                          .toggleTheme(); // تغيير الثيم عند الضغط على أيقونة الثيم
                    }

                    if (index == 4) {
                      Get.to(() => const AthkarScreen(),
                          transition: Transition.leftToRight);
                    } else {
                      controller.remove(); // تنفيذ الإجراءات الأخرى
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: controller.isLightTheme.value
                          ? Colors.white.withOpacity(.7)
                          : Colors.black.withOpacity(.7),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        index == 0
                            ? Obx(() {
                                return Icon(
                                  controller.isLightTheme.value
                                      ? Icons
                                          .nightlight_round // أيقونة الثيم الفاتح
                                      : Icons.wb_sunny, // أيقونة الثيم الداكن
                                  color: controller.isLightTheme.value
                                      ? Colors.black
                                      : Colors.white,
                                );
                              })
                            : Obx(() {
                                return Icon(
                                  homeModelList[index]
                                      .icon
                                      .icon, // الأيقونة من القائمة
                                  color: controller.isLightTheme.value
                                      ? Colors.black
                                      : Colors.white,
                                );
                              }),
                        const SizedBox(height: 4),
                        index == 0
                            ? Obx(() {
                                return Text(
                                  controller.isLightTheme.value
                                      ? 'داكن'
                                      : 'فاتح' ,
                                  style: TextStyle(
                                      color: controller.isLightTheme.value
                                          ? Colors.black
                                          : Colors.white),
                                );
                              })
                            : Text(
                                homeModelList[index].text,
                                style: TextStyle(
                                  color: controller.isLightTheme.value
                                      ? Colors.black
                                      : Colors.white,
                                ),
                              ),
                      ],
                    ),
                  ),
                ),
              ));
        }));
  }
}
