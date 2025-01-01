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
        child: Container(
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(.5),
              borderRadius: BorderRadius.circular(38),
            ),
            alignment: Alignment.center,
            width: 70,
            height: 300,
            child: ListView.separated(
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 15),
                itemCount: homeModelList.length,
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                itemBuilder: (context, index) => InkWell(
                    onTap: () {
                      if (index == 3) {
                        Get.to(() => const AthkarScreen(),
                            transition: Transition.leftToRight);
                      } else {
                        controller.remove();
                      }
                    },
                    child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 2),
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(.7),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(),
                        ),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              homeModelList[index].icon,
                              const SizedBox(height: 4),
                              Text(homeModelList[index].text,
                                  style: const TextStyle(color: Colors.white))
                            ]))))));
  }
}
