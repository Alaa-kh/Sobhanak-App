import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

abstract class HomeController extends GetxController {
  void add();
  void remove();
  void addToaThkarList();
}

class HomeControllerImp extends HomeController {
  RxMap<String, int> athkarCounts =
      <String, int>{}.obs; // خريطة لتخزين عداد الأذكار
  Rx<String> thekr = ''.obs;
  Rx<int> selected = 0.obs;
  TextEditingController thekrController = TextEditingController();
  final GetStorage box = GetStorage();
  RxBool isNewThekrAdded = false.obs; // لتحديد ما إذا كان هناك ذكر جديد

  HomeControllerImp() {
    // تحميل البيانات المحفوظة
    var storedCounts = box.read<Map<String, dynamic>>('athkarCounts');
    if (storedCounts != null) {
      // تحويل الخريطة المخزنة إلى RxMap وتجنب التكرار
      athkarCounts.addAll(Map<String, int>.from(storedCounts));
    }

    // تحميل الأذكار المخزنة وإضافتها إلى القائمة مع التأكد من عدم التكرار
    List<String> storedAthkar =
        List<String>.from(box.read<List<dynamic>>('athkarList') ?? []);
    for (String thekr in storedAthkar) {
      if (!athkarList.contains(thekr)) {
        athkarList.add(thekr); // إضافة الذكر إذا لم يكن موجودًا
      }
    }
  }

  @override
  void onClose() {
    thekrController.clear();
    super.onClose();
  }

  @override
  void addToaThkarList() {
    String newThekr = thekrController.text;

    if (newThekr.isEmpty) {
      // عرض رسالة تنبيه إذا كان الفورم فارغًا
      Get.snackbar('!تنبيه', '',
          backgroundColor: Colors.red,
          snackPosition: SnackPosition.BOTTOM,
          titleText: const Text('!تنبيه',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.right),
          messageText: const Text('لم تدخل ذكر جديد! أعد المحاولة مرة أخرى',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              textAlign: TextAlign.right),
          margin: const EdgeInsets.all(10),
          borderRadius: 10,
          animationDuration: const Duration(milliseconds: 800));
    } else if (!athkarList.contains(newThekr)) {
      // إضافة الذكر إلى القائمة إذا لم يكن مكررًا
      athkarList.add(newThekr);

      // حفظ الذكر المضاف في GetStorage
      box.write('athkarList', athkarList.toList());

      // تحديث العدادات للأذكار
      athkarCounts[newThekr] = (athkarCounts[newThekr] ?? 0) + 1;
      box.write('athkarCounts', athkarCounts()); // حفظ عداد الأذكار

      // تحديث حالة التمرير التلقائي
      isNewThekrAdded.value = true;

      // إغلاق الـ Dialog
      Get.back();
    } else {
      // إذا كان الذكر موجودًا بالفعل في القائمة
      Get.snackbar('!تنبيه', '',
          backgroundColor: Colors.red,
          snackPosition: SnackPosition.BOTTOM,
          titleText: const Text('!تنبيه',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.right),
          messageText: const Text('الذكر موجود بالفعل في القائمة!',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              textAlign: TextAlign.right),
          margin: const EdgeInsets.all(10),
          borderRadius: 10,
          animationDuration: const Duration(milliseconds: 800));
    }
    update();
  }

  @override
  void add() {
    // تحديث عداد الذكر الحالي
    if (thekr.isNotEmpty) {
      athkarCounts[thekr.value] = (athkarCounts[thekr.value] ?? 0) + 1;
      box.write('athkarCounts', athkarCounts()); // حفظ البيانات
    }
  }

  @override
  void remove() {
    if (thekr.isNotEmpty && athkarCounts.containsKey(thekr.value)) {
      athkarCounts[thekr.value] = 0;
      box.write('athkarCounts', athkarCounts()); // تحديث البيانات
    }
  }

  void updateThekr(String newThekr) {
    thekr.value = newThekr;
    if (!athkarCounts.containsKey(newThekr)) {
      athkarCounts[newThekr] = 0; // إضافة الذكر إلى الخريطة إذا لم يكن موجودًا
    }
    box.write(
        'athkarCounts', athkarCounts()); // حفظ العدادات في التخزين المحلي
  }

  RxList<String> athkarList = [
    'لا إله إلا أنت سبحانك إني كنت من الظالمين',
    'لا إله إلا الله وحده لا شريك له , له الملك وله الحمد وهو على كل شيء قدير',
    'أعوذ بكلمات الله التامات من شر ماخلق',
    'سبحان الله وبحمده , سبحان الله العظيم',
    'أستغفر الله وأتوب  إليه',
    'سبحان الله وبحمده',
    'سبحان الله',
    'الحمد لله',
    'لا إله إلا الله',
    'الله أكبر',
  ].obs;
}

