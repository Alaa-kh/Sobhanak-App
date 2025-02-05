import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sobhanak_/controller/home_controller.dart';
import 'package:sobhanak_/view/athkar/widgets/athkar_edit_button_widget.dart';

class AthkarListWidget extends StatelessWidget {
  const AthkarListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeControllerImp controller = Get.find<HomeControllerImp>();

    return Expanded(child: Obx(() {
      return ListView.separated(
          padding: const EdgeInsets.symmetric(vertical: 10),
          itemCount: controller.athkarList.length,
          itemBuilder: (context, index) {
            return InkWell(
                onTap: () {
                  controller.updateThekr(controller.athkarList[index]);
                  Get.back();
                },
                child: Padding(
                    padding: const EdgeInsets.only(
                        top: 15, bottom: 15, right: 18, left: 2),
                    child: Row(children: [
                      Row(children: [
                        if (controller.athkarList.length > 1)
                          IconButton(
                              onPressed: () => controller.deleteThekr(index),
                              icon: const Icon(Icons.delete,
                                  color: Colors.red, size: 15)),
                        AthkarEditButtonWidget(index: index)
                      ]),
                      Obx(() => Padding(
                          padding: const EdgeInsets.only(left: 17.0),
                          child: Text(
                              '${controller.athkarCounts[controller.athkarList[index]] ?? 0}',
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 23)))),
                      const SizedBox(width: 30),
                      Expanded(
                          child: Text(controller.athkarList[index],
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.end))
                    ])));
          },
          separatorBuilder: (context, index) =>
              const Divider(thickness: 0.3, color: Colors.white54));
    }));
  }
}
