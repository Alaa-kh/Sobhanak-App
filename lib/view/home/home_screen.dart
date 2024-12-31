import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sobhanak/controller/home_controller.dart';

class HomeScreen extends GetView<HomeControllerImp> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(HomeControllerImp());
    return Expanded(
      child: Scaffold(
        body: GetBuilder<HomeControllerImp>(
          builder: (_) => GestureDetector(
            onTap: () => controller.add(),
            child: Stack(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage(
                        'assets/images/kate-mishchankova-Gb_fZjvaLxw-unsplash.jpg',
                      ),
                    ),
                  ),
                  width: double.infinity,
                ),
                Container(
                  color: Colors.black.withOpacity(0.3),
                  width: double.infinity,
                  height: double.infinity,
                ),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'استغفر الله',
                        style: TextStyle(fontSize: 40, color: Colors.white),
                      ),
                      Text(
                        '${controller.count.toString()}',
                        style: TextStyle(fontSize: 40, color: Colors.white),
                      ),
                    ],
                  ),
                ),
        
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.black.withOpacity(.5),
                        borderRadius: BorderRadius.circular(8)),
                    alignment: Alignment.center,

                    width: 70,
                    // height: MediaQuery.of(context).size.height,
                    height: 350,
                    child: ListView.separated(
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 10),
                      itemCount: 4,
                      shrinkWrap: true,
                      physics: const ScrollPhysics(),
                      itemBuilder: (context, index) => InkWell(onTap: () => controller.remove(),
                        child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 8),
                            decoration: BoxDecoration(
                                color: Colors.black.withOpacity(.7),
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all()),
                            width: 60,
                            height: 60,
                            child: Column(
                              mainAxisAlignment:
                                  MainAxisAlignment.center,
                              crossAxisAlignment:
                                  CrossAxisAlignment.center, 
                              children: [
                                Icon(
                                  Icons.settings_backup_restore_outlined,
                                  color: Colors.white,
                                ),
                                SizedBox(height: 4), 
                                Text(
                                  'تصفير',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            )),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
