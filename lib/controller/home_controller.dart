import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

abstract class HomeController extends GetxController {
  void add();
  void remove();
}

class HomeControllerImp extends HomeController {
  int count = 0;
  final box = GetStorage();

  HomeControllerImp() {
    count = box.read('count') ?? 0;
  }

  @override
  void add() {
    count++;
    box.write('count', count);
    update();
  }

  @override
  void remove() {
    count=0;
    box.remove('count');
    update();
  }
}
