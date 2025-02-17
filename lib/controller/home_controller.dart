import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:just_audio/just_audio.dart';
import 'package:url_launcher/url_launcher.dart';

abstract class HomeController extends GetxController {
  void add();
  void remove();
  void addToaThkarList();
  void deleteThekr(int index);
  void handleAddThekr();
}

class HomeControllerImp extends HomeController {
  RxBool isPlaying = false.obs;
  RxBool isSoundEnabled = false.obs;
  RxBool showSidebar = false.obs;

  RxMap<String, int> athkarCounts = <String, int>{}.obs;
  Rx<String> thekr = 'الحمد لله'.obs;
  Rx<int> selected = 0.obs;
  TextEditingController thekrController = TextEditingController();
  final GetStorage box = GetStorage();
  RxBool isNewThekrAdded = false.obs;

  RxList<String> athkarList = <String>[].obs;
  ScrollController scrollController = ScrollController();

  HomeControllerImp() {
    bool? storedTheme = box.read<bool>('isLightTheme');
    if (storedTheme != null) {
      isLightTheme.value = storedTheme;
    }
    var storedCounts = box.read<Map<String, dynamic>>('athkarCounts');
    if (storedCounts != null) {
      athkarCounts.addAll(Map<String, int>.from(storedCounts));
    }

    List<String> storedAthkar =
        List<String>.from(box.read<List<dynamic>>('athkarList') ?? []);
    athkarList.addAll(storedAthkar);

    if (!athkarList.contains('الحمد لله')) {
      athkarList.add('الحمد لله');
      athkarCounts['الحمد لله'] = 0;
      box.write('athkarList', athkarList.toList());
      box.write('athkarCounts', athkarCounts());
    }
  }

  Future<void> playSound() async {
    try {
      await player.setAsset('assets/sounds/mixkit_sound.mp3');
      player.play();
    } catch (e) {
      print('خطأ أثناء تشغيل الصوت: $e');
    }
  }

  Future<void> stopSound() async {
    try {
      await player.stop();
    } catch (e) {
      print('خطأ أثناء إيقاف الصوت: $e');
    }
  }

  @override
  void handleAddThekr() {
    if (thekrController.text.isNotEmpty) {
      String newThekr = thekrController.text.trim();

      if (!athkarList.contains(newThekr)) {
        addToaThkarList();
        isNewThekrAdded.value = true;

        Future.delayed(const Duration(milliseconds: 300), () {
          if (scrollController.hasClients) {
            scrollController.jumpTo(scrollController.position.maxScrollExtent);
          }
        });
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
            'الذكر موجود بالفعل في القائمة',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            textAlign: TextAlign.right,
          ),
          margin: const EdgeInsets.all(10),
          borderRadius: 10,
          animationDuration: const Duration(milliseconds: 800),
        );
      }
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
    scrollController.dispose();
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

  final player = AudioPlayer();

  @override
  void add() async {
    if (thekr.isNotEmpty) {
      athkarCounts[thekr.value] = (athkarCounts[thekr.value] ?? 0) + 1;
      box.write('athkarCounts', athkarCounts());
    }
    if (isSoundEnabled.value) {
      try {
        await player.setAsset('assets/sounds/mixkit_sound.mp3');
        player.play();
      } catch (e) {
        print('خطأ أثناء تشغيل الصوت: $e');
      }
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
    thekr.value = newThekr;
    selected.value = athkarList.indexOf(newThekr);
    box.write('athkarCounts', athkarCounts());
    update();
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

    box.write('athkarList', athkarList.toList());
    box.write('athkarCounts', athkarCounts());

    update();
  }

  RxBool isLightTheme = false.obs;
  void toggleTheme() {
    Future.delayed(Duration.zero, () {
      isLightTheme.value = !isLightTheme.value;
      box.write('isLightTheme', isLightTheme.value);
      Get.changeTheme(
          isLightTheme.value ? ThemeData.light() : ThemeData.dark());
    });
  }

  void openEmail() async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'alaakhaled22001@gmail.com',
      query:  
      'subject=${Uri.encodeComponent('تواصل مع الدعم')}&body=${Uri.encodeComponent('مرحبًا، أريد التواصل بشأن..')}'
    );

    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    } else {
      throw 'Could not open email client';
    }
  }

  void handleEditThekr(int index) {
    String updatedThekr = thekrController.text.trim();
    if (updatedThekr.isEmpty) {
      Get.snackbar('!تنبيه', '',
          backgroundColor: Colors.red,
          snackPosition: SnackPosition.BOTTOM,
          titleText: const Text('!تنبيه',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.right),
          messageText: const Text('!لا يمكن أن يكون الذكر فارغًا',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              textAlign: TextAlign.right),
          margin: const EdgeInsets.all(10),
          borderRadius: 10,
          animationDuration: const Duration(milliseconds: 800));
    } else if (athkarList.contains(updatedThekr)) {
      Get.snackbar('!تنبيه', '',
          backgroundColor: Colors.red,
          snackPosition: SnackPosition.BOTTOM,
          titleText: const Text('!تنبيه',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.right),
          messageText: const Text('!الذكر موجود مسبقًا',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              textAlign: TextAlign.right),
          margin: const EdgeInsets.all(10),
          borderRadius: 10,
          animationDuration: const Duration(milliseconds: 800));
    } else {
      String oldThekr = athkarList[index];
      athkarList[index] = updatedThekr;

      athkarCounts[updatedThekr] = athkarCounts.remove(oldThekr) ?? 0;

      box.write('athkarList', athkarList.toList());
      box.write('athkarCounts', athkarCounts());

      Get.back();

      Get.snackbar('نجاح', '',
          backgroundColor: Colors.green,
          snackPosition: SnackPosition.BOTTOM,
          titleText: const Text('!تنبيه',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.right),
          messageText: const Text('تم تعديل الذكر بنجاح',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              textAlign: TextAlign.right),
          margin: const EdgeInsets.all(10),
          borderRadius: 10,
          animationDuration: const Duration(milliseconds: 800));

      update();
    }
  }
}
