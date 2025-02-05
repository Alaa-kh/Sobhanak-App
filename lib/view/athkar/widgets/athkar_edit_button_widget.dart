import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sobhanak_/controller/home_controller.dart';

class AthkarEditButtonWidget extends StatelessWidget {
  const AthkarEditButtonWidget({super.key, required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    final HomeControllerImp controller = Get.find<HomeControllerImp>();

    return InkWell(
        onTap: () {
          controller.thekrController.text = controller.athkarList[index];

          Get.dialog(
              AlertDialog(
                  backgroundColor: const Color.fromARGB(255, 206, 206, 206),
                  contentPadding: EdgeInsets.zero,
                  content: Stack(clipBehavior: Clip.none, children: [
                    Positioned(
                        top: 1,
                        right: 1,
                        child: IconButton(
                            onPressed: () => Get.back(),
                            icon: const Icon(Icons.close),
                            color: Colors.black,
                            tooltip: 'إغلاق')),
                    SizedBox(
                        width: 350,
                        height: 250,
                        child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 20),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Transform(
                                            alignment: Alignment.center,
                                            transform:
                                                Matrix4.rotationX(3.14159),
                                            child: Image.asset(
                                                'assets/animations/Animation - 1737922794344.gif',
                                                width: 40)),
                                        const Text('تعديل الذكر',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold))
                                      ]),
                                  const SizedBox(height: 20),
                                  TextField(
                                      controller: controller.thekrController,
                                      textDirection: TextDirection.rtl,
                                      decoration: const InputDecoration(
                                          hoverColor:
                                              Color.fromARGB(255, 0, 26, 7),
                                          errorBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Color.fromARGB(
                                                      255, 0, 26, 7))),
                                          disabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Color.fromARGB(
                                                      255, 0, 26, 7))),
                                          enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Color.fromARGB(
                                                      255, 0, 26, 7))),
                                          focusColor:
                                              Color.fromARGB(255, 0, 26, 7),
                                          hintText: 'قم بتعديل الذكر هنا ..',
                                          border:
                                              OutlineInputBorder(borderSide: BorderSide(color: Color.fromARGB(255, 0, 26, 7))),
                                          hintTextDirection: TextDirection.rtl)),
                                  const SizedBox(height: 20),
                                  InkWell(
                                      onTap: () {
                                        controller.handleEditThekr(index);
                                        Get.back();
                                      },
                                      child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 8),
                                          alignment: Alignment.center,
                                          width: 150,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              color: const Color.fromARGB(
                                                  255, 0, 26, 7)),
                                          child: const Text('تعديل',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15))))
                                ])))
                  ])),
              barrierDismissible: true);
        },
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: const Icon(Icons.edit, color: Colors.green, size: 15)));
  }
}
