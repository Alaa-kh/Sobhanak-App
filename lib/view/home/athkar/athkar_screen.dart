import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sobhanak/controller/home_controller.dart';

class AthkarScreen extends StatelessWidget {
  const AthkarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeControllerImp controller = Get.find<HomeControllerImp>();
    ScrollController scrollController = ScrollController();

    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: const Color.fromARGB(255, 0, 26, 7),
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
                                // التأكد من أن الفورم غير فارغ
                                if (controller
                                    .thekrController.text.isNotEmpty) {
                                  controller.addToaThkarList();
                                  // التمرير إلى الأسفل عند إضافة ذكر جديد
                                  controller.isNewThekrAdded.value =
                                      true; // تعيين المتغير إلى true
                                } else {
                                  Get.snackbar(
                                    '!تنبيه',
                                    '',
                                    backgroundColor: Colors.red,
                                    snackPosition: SnackPosition.BOTTOM,
                                    titleText: const Text(
                                      '!تنبيه',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.right,
                                    ),
                                    messageText: const Text(
                                      'لم تدخل ذكر جديد! أعد المحاولة مرة أخرى',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.right,
                                    ),
                                    margin: const EdgeInsets.all(10),
                                    borderRadius: 10,
                                    animationDuration:
                                        const Duration(milliseconds: 800),
                                  );
                                }
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
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            end: Alignment.bottomCenter,
            begin: Alignment.center,
            colors: [
              Color.fromARGB(255, 0, 26, 7),
              Color(0xff151515),
              Color(0xff151515),
            ],
          ),
        ),
        child: SingleChildScrollView(
          controller: scrollController,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const SizedBox(height: 50),
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
              Obx(() {
                return ListView.separated(
                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  itemCount: controller.athkarList.length,
                  itemBuilder: (context, index) {
                    // التمرير التلقائي فقط عند إضافة ذكر جديد
                    if (controller.isNewThekrAdded.value &&
                        index == controller.athkarList.length - 1) {
                      Future.delayed(Duration(milliseconds: 200), () {
                        scrollController
                            .jumpTo(scrollController.position.maxScrollExtent);
                      });
                      // تعيين المتغير مرة أخرى إلى false بعد التمرير
                      controller.isNewThekrAdded.value = false;
                    }

                    return InkWell(
                      onTap: () {
                        controller.updateThekr(controller.athkarList[index]);
                        Get.back();
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 18.0, vertical: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Obx(() => Text(
                                  '${controller.athkarCounts[controller.athkarList[index]] ?? 0}',
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 18),
                                )),
                            const SizedBox(width: 60),
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
                  separatorBuilder: (context, index) =>
                      const Divider(thickness: .3),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
// import 'package:flutter_slidable/flutter_slidable.dart';

// class AthkarScreen extends StatelessWidget {
//   const AthkarScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final HomeControllerImp controller = Get.find<HomeControllerImp>();
//     ScrollController scrollController = ScrollController();

//     return Scaffold(
//       appBar: AppBar(
//         foregroundColor: Colors.white,
//         backgroundColor: const Color.fromARGB(255, 0, 26, 7),
//         actions: [
//           IconButton(
//               onPressed: () {
//                 Get.dialog(
//                     AlertDialog(
//                         backgroundColor:
//                             const Color.fromARGB(255, 206, 206, 206),
//                         contentPadding: EdgeInsets.zero,
//                         content: Stack(clipBehavior: Clip.none, children: [
//                           // زر الإغلاق
//                           Positioned(
//                             top: 1,
//                             right: 1,
//                             child: IconButton(
//                               onPressed: () {
//                                 Get.back(); // يغلق الـ Dialog
//                               },
//                               icon: const Icon(Icons.close),
//                               color: Colors.black,
//                               tooltip: 'إغلاق',
//                             ),
//                           ),
//                           // المحتوى الرئيسي
//                           SizedBox(
//                               width: 350,
//                               height: 250,
//                               child: Padding(
//                                   padding: const EdgeInsets.symmetric(
//                                       horizontal: 20, vertical: 20),
//                                   child: Column(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.center,
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.center,
//                                       children: [
//                                         const Text(
//                                           'أدخل الذكر الذي تريده هنا',
//                                           textAlign: TextAlign.center,
//                                           style: TextStyle(
//                                             color: Colors.black,
//                                             fontWeight: FontWeight.bold,
//                                           ),
//                                         ),
//                                         const SizedBox(height: 20),
//                                         TextField(
//                                           controller:
//                                               controller.thekrController,
//                                           textDirection: TextDirection.rtl,
//                                           decoration: const InputDecoration(
//                                               hoverColor:
//                                                   Color.fromARGB(255, 0, 26, 7),
//                                               errorBorder: OutlineInputBorder(
//                                                   borderSide: BorderSide(
//                                                       color: Color.fromARGB(
//                                                           255, 0, 26, 7))),
//                                               disabledBorder:
//                                                   OutlineInputBorder(
//                                                       borderSide: BorderSide(
//                                                           color: Color.fromARGB(
//                                                               255, 0, 26, 7))),
//                                               enabledBorder: OutlineInputBorder(
//                                                   borderSide: BorderSide(
//                                                       color:
//                                                           Color.fromARGB(255, 0, 26, 7))),
//                                               focusColor: Color.fromARGB(255, 0, 26, 7),
//                                               hintText: 'اكتب هنا ..',
//                                               border: OutlineInputBorder(borderSide: BorderSide(color: Color.fromARGB(255, 0, 26, 7))),
//                                               hintTextDirection: TextDirection.rtl),
//                                         ),
//                                         const SizedBox(height: 20),
//                                         InkWell(
//                                           onTap: () {
//                                             controller.addToaThkarList();
//                                           },
//                                           child: Container(
//                                             padding: const EdgeInsets.symmetric(
//                                                 vertical: 8),
//                                             alignment: Alignment.center,
//                                             width: 150,
//                                             decoration: BoxDecoration(
//                                               borderRadius:
//                                                   BorderRadius.circular(5),
//                                               color: const Color.fromARGB(
//                                                   255, 0, 26, 7),
//                                             ),
//                                             child: const Text('حفظ',
//                                                 style: TextStyle(
//                                                     color: Colors.white,
//                                                     fontWeight: FontWeight.bold,
//                                                     fontSize: 15)),
//                                           ),
//                                         ),
//                                       ]))),
//                         ])),
//                     barrierDismissible: false);
//               },
//               icon: const Icon(Icons.add, color: Colors.white))
//         ],
//       ),
//       body: Container(
//           decoration: const BoxDecoration(
//               gradient: LinearGradient(
//                   end: Alignment.bottomCenter,
//                   begin: Alignment.center,
//                   colors: [
//                 Color.fromARGB(255, 0, 26, 7),
//                 Color(0xff151515),
//                 Color(0xff151515)
//               ])),
//           child: SingleChildScrollView(
//             controller: scrollController,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.end,
//               children: [
//                 const SizedBox(height: 50),
//                 const Padding(
//                     padding: EdgeInsets.symmetric(horizontal: 18.0),
//                     child: Text('أذكارك',
//                         style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 42,
//                             fontWeight: FontWeight.bold))),
//                 Obx(() {
//                   return ListView.separated(
//                     shrinkWrap: true,
//                     physics: const ScrollPhysics(),
//                     itemCount: controller.athkarList.length,
//                     itemBuilder: (context, index) {
//                       return Slidable(
//                         direction: Axis.horizontal,
//                         endActionPane: ActionPane(
//                           motion: ScrollMotion(),
//                           children: [
//                             SlidableAction(
//                               onPressed: (BuildContext context) {
//                               },
//                               label: 'حذف',
//                               backgroundColor: Colors.red,
//                               icon: Icons.delete,
//                             ),
//                           ],
//                         ),
//                         child: InkWell(
//                           onTap: () {
//                             controller
//                                 .updateThekr(controller.athkarList[index]);
//                             Get.back();
//                           },
//                           child: Padding(
//                             padding: const EdgeInsets.symmetric(
//                                 horizontal: 18.0, vertical: 15),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Obx(() => Text(
//                                     '${controller.athkarCounts[controller.athkarList[index]] ?? 0} ',
//                                     style: const TextStyle(
//                                         color: Colors.white, fontSize: 18))),
//                                 const SizedBox(width: 60),
//                                 Expanded(
//                                   child: Text(controller.athkarList[index],
//                                       style: const TextStyle(
//                                           color: Colors.white, fontSize: 22),
//                                       maxLines: 3,
//                                       overflow: TextOverflow.ellipsis,
//                                       textAlign: TextAlign.end),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       );
//                     },
//                     separatorBuilder: (context, index) =>
//                         const Divider(thickness: .3),
//                   );
//                 }),
//               ],
//             ),
//           )),
//     );
//   }
// }
