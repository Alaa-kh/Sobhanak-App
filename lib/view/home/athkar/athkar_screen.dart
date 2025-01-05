import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sobhanak_app/controller/home_controller.dart';

class AthkarScreen extends StatelessWidget {
  const AthkarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeControllerImp controller = Get.find<HomeControllerImp>();

    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: controller.isLightTheme.value
            ? const Color.fromARGB(255, 41, 38, 38).withOpacity(.7)
            :  const Color.fromARGB(255, 0, 26, 7),
        actions: [
          IconButton(
            onPressed: () {
              controller.thekrController.clear();
              Get.dialog(
                AlertDialog(
                  backgroundColor: const Color.fromARGB(255, 206, 206, 206),
                  contentPadding: EdgeInsets.zero,
                  content: Stack(clipBehavior: Clip.none, children: [
                    // زر الإغلاق
                    Positioned(
                      top: 1,
                      right: 1,
                      child: IconButton(
                        onPressed: () {
                          Get.back(); // يغلق الـ Dialog
                        },
                        icon: const Icon(Icons.close),
                        color: Colors.black,
                        tooltip: 'إغلاق',
                      ),
                    ),
                    // المحتوى الرئيسي
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
                            const Text(
                              'أدخل الذكر الذي تريده هنا',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 20),
                            TextField(
                              controller: controller.thekrController,
                              textDirection: TextDirection.rtl,
                              decoration: const InputDecoration(
                                hoverColor: Color.fromARGB(255, 0, 26, 7),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromARGB(255, 0, 26, 7)),
                                ),
                                disabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromARGB(255, 0, 26, 7)),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromARGB(255, 0, 26, 7)),
                                ),
                                focusColor: Color.fromARGB(255, 0, 26, 7),
                                hintText: 'اكتب هنا ..',
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromARGB(255, 0, 26, 7)),
                                ),
                                hintTextDirection: TextDirection.rtl,
                              ),
                            ),
                            const SizedBox(height: 20),
                            InkWell(
                              onTap: () {
                                controller.handleAddThekr();
                              },
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8),
                                alignment: Alignment.center,
                                width: 150,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: const Color.fromARGB(255, 0, 26, 7),
                                ),
                                child: const Text(
                                  'حفظ',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ]),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                ),
                barrierDismissible: false,
              );
            },
            icon: const Icon(Icons.add, color: Colors.white),
          )
        ],
      ),
      body: Container(
        decoration:  BoxDecoration(
          gradient: LinearGradient(
            end: Alignment.bottomCenter,
            begin: Alignment.center,
            colors: [
      controller.isLightTheme.value?const Color.fromARGB(255, 41, 38, 38).withOpacity(.7):         Color.fromARGB(255, 0, 26, 7),
              Color(0xff151515),
              Color(0xff151515),
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 18.0),
              child: Text(
                'أذكارك',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 42,
                    fontWeight: FontWeight.bold),
              ),
            ),
           Expanded(
              child: Obx(() {
                if (controller.athkarList.isEmpty) {
                  return const Center(
                    child: Text(
                      'لا يوجد أذكار بعد!',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                }
                return ListView.separated(
                  controller:
                      controller.scrollController, // ربط الـ ScrollController
                  itemCount: controller.athkarList.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        controller.updateThekr(controller.athkarList[index]);
                        Get.back(); // العودة إلى الشاشة الرئيسية
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 18),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            if (controller.athkarList.length > 1)
                              IconButton(
                                onPressed: () => controller.deleteThekr(index),
                                icon: const Icon(Icons.delete,
                                    color: Colors.red, size: 20),
                              ),
                            Obx(() => Text(
                                  '${controller.athkarCounts[controller.athkarList[index]] ?? 0}',
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 25),
                                )),
                            const SizedBox(width: 20),
                            Expanded(
                              child: Text(
                                controller.athkarList[index],
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 22),
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.end,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => const Divider(
                    thickness: 0.3,
                    color: Colors.white54,
                  ),
                );
              }),
            )

          ],
        ),
      ),
    );
  }
}
