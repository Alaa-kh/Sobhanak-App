import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sobhanak_/controller/home_controller.dart';
import 'package:sobhanak_/view/athkar/widgets/athkar_add_theker_button_widget.dart';
import 'package:sobhanak_/view/athkar/widgets/athkar_list_widget.dart';

class AthkarScreen extends StatelessWidget {
  const AthkarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeControllerImp controller = Get.find<HomeControllerImp>();

    return Scaffold(
        extendBodyBehindAppBar: true,
        body: Stack(children: [
          Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(controller.isLightTheme.value
                          ? 'assets/images/light.jpg'
                          : 'assets/images/dark.jpg'),
                      fit: BoxFit.cover))),
          BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
              child: Container(color: Colors.black.withValues(alpha: .5))),
          Column(children: [
            Container(
                decoration: const BoxDecoration(color: Colors.transparent),
                child: AppBar(
                    surfaceTintColor: Colors.transparent,
                    centerTitle: true,
                    title: const Text('أذكارك',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 32,
                            fontWeight: FontWeight.bold)),
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    actions: [AthkarAddThekerButtonWidget()],
                    foregroundColor: Colors.white)),
            AthkarListWidget()
          ])
        ]));
  }
}
