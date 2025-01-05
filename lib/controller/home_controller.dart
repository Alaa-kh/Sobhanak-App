import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

abstract class HomeController extends GetxController {
  void add();
  void remove();
  void addToaThkarList();
  void deleteThekr(int index);
  void handleAddThekr();
  // void addVibrate();
}

class HomeControllerImp extends HomeController {
  RxMap<String, int> athkarCounts =
      <String, int>{}.obs; // خريطة لتخزين عداد الأذكار
  Rx<String> thekr = 'الحمد لله'.obs; // الذكر الحالي الافتراضي
  Rx<int> selected = 0.obs;
  TextEditingController thekrController = TextEditingController();
  final GetStorage box = GetStorage();
  RxBool isNewThekrAdded = false.obs;

  RxList<String> athkarList = <String>[].obs; // قائمة الأذكار المحفوظة
  ScrollController scrollController = ScrollController(); // سكروول التحكم

  HomeControllerImp() {// قراءة الثيم المخزن عند بدء التطبيق
    bool? storedTheme = box.read<bool>('isLightTheme');
    if (storedTheme != null) {
      isLightTheme.value = storedTheme; // تطبيق الثيم المخزن
    }
    // تحميل البيانات المحفوظة
    var storedCounts = box.read<Map<String, dynamic>>('athkarCounts');
    if (storedCounts != null) {
      athkarCounts.addAll(Map<String, int>.from(storedCounts));
    }

    // تحميل قائمة الأذكار المخزنة
    List<String> storedAthkar =
        List<String>.from(box.read<List<dynamic>>('athkarList') ?? []);
    athkarList.addAll(storedAthkar);

    // إضافة الذكر الافتراضي "الحمد لله" إذا لم يكن موجودًا
    if (!athkarList.contains('الحمد لله')) {
      athkarList.add('الحمد لله');
      athkarCounts['الحمد لله'] = 0;
      box.write('athkarList', athkarList.toList());
      box.write('athkarCounts', athkarCounts());
    }
  }
  @override
  void handleAddThekr() {
    if (thekrController.text.isNotEmpty) {
      String newThekr = thekrController.text.trim();

      // التحقق إذا كان الذكر موجودًا بالفعل في القائمة
      if (!athkarList.contains(newThekr)) {
        addToaThkarList();
        isNewThekrAdded.value = true;

        // التمرير إلى أسفل بعد إضافة الذكر الجديد
        Future.delayed(const Duration(milliseconds: 300), () {
          if (scrollController.hasClients) {
            scrollController.jumpTo(scrollController.position.maxScrollExtent);
          }
        });
      } else {
        // عرض تنبيه إذا كان الذكر موجودًا بالفعل
        Get.snackbar(
          '!تنبيه',
          '',
          backgroundColor: Colors.red,
          snackPosition: SnackPosition.BOTTOM,
          titleText: const Text(
            '!تنبيه',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            textAlign: TextAlign.right,
          ),
          messageText: const Text(
            'الذكر موجود بالفعل في القائمة',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            textAlign: TextAlign.right,
          ),
          margin: const EdgeInsets.all(10),
          borderRadius: 10,
          animationDuration: const Duration(milliseconds: 800),
        );
      }

      // إغلاق الـ Dialog بعد إضافة الذكر بنجاح أو إذا كان الذكر موجودًا
      // Get.back();
    } else {
      Get.snackbar(
        '!تنبيه',
        '',
        backgroundColor: Colors.orange,
        snackPosition: SnackPosition.BOTTOM,
        titleText: const Text(
          '!تنبيه',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          textAlign: TextAlign.right,
        ),
        messageText: const Text(
          'لم تدخل ذكر جديد! أعد المحاولة مرة أخرى',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          textAlign: TextAlign.right,
        ),
        margin: const EdgeInsets.all(10),
        borderRadius: 10,
        animationDuration: const Duration(milliseconds: 800),
      );
    }
  }

  @override
  void onClose() {
    thekrController.clear();
    scrollController
        .dispose(); // التأكد من التخلص من الـ ScrollController عند الإغلاق
    super.onClose();
  }

  @override
  void addToaThkarList() {
    String newThekr = thekrController.text.trim();

    if (newThekr.isEmpty) {
      Get.snackbar('!تنبيه', 'لم تدخل ذكر جديد! أعد المحاولة مرة أخرى',
          backgroundColor: Colors.red, snackPosition: SnackPosition.BOTTOM);
    } else if (!athkarList.contains(newThekr)) {
      athkarList.add(newThekr);

      // تحديث التخزين المحلي
      box.write('athkarList', athkarList.toList());

      athkarCounts[newThekr] = 0;
      box.write('athkarCounts', athkarCounts());

      isNewThekrAdded.value = true;
      Get.back();
    } else {
      Get.snackbar(
        '!تنبيه',
        '',
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.BOTTOM,
        titleText: const Text(
          '!تنبيه',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          textAlign: TextAlign.right,
        ),
        messageText: const Text(
          '!الذكر موجود بالفعل في القائمة',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          textAlign: TextAlign.right,
        ),
        margin: const EdgeInsets.all(10),
        borderRadius: 10,
        animationDuration: const Duration(milliseconds: 800),
      );
    }
    update();
  }

  @override
  void add() {
    if (thekr.isNotEmpty) {
      athkarCounts[thekr.value] = (athkarCounts[thekr.value] ?? 0) + 1;
      box.write('athkarCounts', athkarCounts());
    }
  }

  @override
  void remove() {
    if (thekr.isNotEmpty && athkarCounts.containsKey(thekr.value)) {
      athkarCounts[thekr.value] = 0;
      box.write('athkarCounts', athkarCounts());
    }
  }

  void updateThekr(String newThekr) {
    thekr.value = newThekr; // تحديث الذكر الحالي
    selected.value = athkarList.indexOf(newThekr); // تحديد العنصر
    box.write('athkarCounts', athkarCounts()); // حفظ العدادات
    update(); // تحديث الواجهة
  }

  @override
  void deleteThekr(int index) {
    String thekrToDelete = athkarList[index];

    athkarList.removeAt(index);
    athkarCounts.remove(thekrToDelete);
    Get.snackbar('!تنبيه', '',
        backgroundColor: Colors.green,
        snackPosition: SnackPosition.BOTTOM,
        titleText: const Text('!تم الحذف',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            textAlign: TextAlign.right),
        messageText: const Text('تم حذف الذكر نهائيًا',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            textAlign: TextAlign.right),
        margin: const EdgeInsets.all(10),
        borderRadius: 10,
        animationDuration: const Duration(milliseconds: 800));

    // تحديث التخزين المحلي
    box.write('athkarList', athkarList.toList());
    box.write('athkarCounts', athkarCounts());

    update();
  }

  RxBool isLightTheme = false.obs; // متغير للتحقق من حالة الثيم (فاتح / داكن)
  void toggleTheme() {
    // تأجيل تغيير الثيم باستخدام Future.delayed
    Future.delayed(Duration.zero, () {
      isLightTheme.value = !isLightTheme.value; // تغيير الحالة
      // تخزين الثيم المختار
      box.write('isLightTheme', isLightTheme.value);
      // تغيير الثيم بناءً على القيمة الجديدة
      Get.changeTheme(
          isLightTheme.value ? ThemeData.light() : ThemeData.dark());
    });
  }


  // @override
  // void addVibrate() {
  //   if (thekr.isNotEmpty) {
  //     // زيادة العداد
  //     athkarCounts[thekr.value] = (athkarCounts[thekr.value] ?? 0) + 1;

  //     // اهتزاز الهاتف عند زيادة العداد
  //     Vibrate.feedback(FeedbackType.medium); // يمكنك اختيار نوع الاهتزاز

  //     // تحديث التخزين المحلي
  //     box.write('athkarCounts', athkarCounts());
  //   }
  // }
}


// class HomeControllerImp extends HomeController {
//   RxMap<String, int> athkarCounts =
//       <String, int>{}.obs; // خريطة لتخزين عداد الأذكار
//   Rx<String> thekr = ''.obs; // الذكر الحالي
//   Rx<int> selected = 0.obs;
//   TextEditingController thekrController = TextEditingController();
//   final GetStorage box = GetStorage();
//   RxBool isNewThekrAdded = false.obs;

//   RxList<String> athkarList = <String>[].obs; // قائمة الأذكار المحفوظة

//   HomeControllerImp() {
//     // تحميل البيانات المحفوظة
//     var storedCounts = box.read<Map<String, dynamic>>('athkarCounts');
//     if (storedCounts != null) {
//       athkarCounts.addAll(Map<String, int>.from(storedCounts));
//     }

//     // تحميل قائمة الأذكار المخزنة
//     List<String> storedAthkar =
//         List<String>.from(box.read<List<dynamic>>('athkarList') ?? []);
//     athkarList.addAll(storedAthkar);
//   }

//   @override
//   void handleAddThekr() {
//     if (thekrController.text.isNotEmpty) {
//       addToaThkarList();
//       isNewThekrAdded.value = true;
//     } else {
//       Get.snackbar(
//         '!تنبيه',
//         '',
//         backgroundColor: Colors.orange,
//         snackPosition: SnackPosition.BOTTOM,
//         titleText: const Text(
//           '!تنبيه',
//           style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//           textAlign: TextAlign.right,
//         ),
//         messageText: const Text(
//           'لم تدخل ذكر جديد! أعد المحاولة مرة أخرى',
//           style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//           textAlign: TextAlign.right,
//         ),
//         margin: const EdgeInsets.all(10),
//         borderRadius: 10,
//         animationDuration: const Duration(milliseconds: 800),
//       );
//     }
//   }

//   @override
//   void onClose() {
//     thekrController.clear();
//     super.onClose();
//   }

//   @override
//   void addToaThkarList() {
//     String newThekr = thekrController.text.trim();

//     if (newThekr.isEmpty) {
//       Get.snackbar('!تنبيه', 'لم تدخل ذكر جديد! أعد المحاولة مرة أخرى',
//           backgroundColor: Colors.red, snackPosition: SnackPosition.BOTTOM);
//     } else if (!athkarList.contains(newThekr)) {
//       athkarList.add(newThekr);

//       // تحديث التخزين المحلي
//       box.write('athkarList', athkarList.toList());

//       athkarCounts[newThekr] = 0;
//       box.write('athkarCounts', athkarCounts());

//       isNewThekrAdded.value = true;
//       Get.back();
//     } else {
//       Get.snackbar(
//         '!تنبيه',
//         '',
//         backgroundColor: Colors.red,
//         snackPosition: SnackPosition.BOTTOM,
//         titleText: const Text(
//           '!تنبيه',
//           style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//           textAlign: TextAlign.right,
//         ),
//         messageText: const Text(
//           '!الذكر موجود بالفعل في القائمة',
//           style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//           textAlign: TextAlign.right,
//         ),
//         margin: const EdgeInsets.all(10),
//         borderRadius: 10,
//         animationDuration: const Duration(milliseconds: 800),
//       );
//     }
//     update();
//   }

//   @override
//   void add() {
//     if (thekr.isNotEmpty) {
//       athkarCounts[thekr.value] = (athkarCounts[thekr.value] ?? 0) + 1;
//       box.write('athkarCounts', athkarCounts());
//     }
//   }

//   @override
//   void remove() {
//     if (thekr.isNotEmpty && athkarCounts.containsKey(thekr.value)) {
//       athkarCounts[thekr.value] = 0;
//       box.write('athkarCounts', athkarCounts());
//     }
//   }

//   void updateThekr(String newThekr) {
//     thekr.value = newThekr; // تحديث الذكر الحالي
//     selected.value = athkarList.indexOf(newThekr); // تحديد العنصر
//     box.write('athkarCounts', athkarCounts()); // حفظ العدادات
//     update(); // تحديث الواجهة
//   }

//   @override
//   void deleteThekr(int index) {
//     String thekrToDelete = athkarList[index];

//     athkarList.removeAt(index);
//     athkarCounts.remove(thekrToDelete);
//     Get.snackbar('!تنبيه', '',
//         backgroundColor: Colors.green,
//         snackPosition: SnackPosition.BOTTOM,
//         titleText: const Text('!تم الحذف',
//             style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             textAlign: TextAlign.right),
//         messageText: const Text('تم حذف الذكر نهائيًا',
//             style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//             textAlign: TextAlign.right),
//         margin: const EdgeInsets.all(10),
//         borderRadius: 10,
//         animationDuration: const Duration(milliseconds: 800));

//     // تحديث التخزين المحلي
//     box.write('athkarList', athkarList.toList());
//     box.write('athkarCounts', athkarCounts());

//     update();
//   }
// }
