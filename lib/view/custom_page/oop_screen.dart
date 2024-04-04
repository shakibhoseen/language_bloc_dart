import 'dart:developer';

import 'package:first_project/view/custom_page/controller/my_controller.dart';
import 'package:flutter/material.dart';

import 'controller/sm_controller.dart';

class OopScreen extends StatefulWidget {
  const OopScreen({super.key});

  @override
  State<OopScreen> createState() => _OopScreenState();
}

class _OopScreenState extends State<OopScreen> {
  final controller = SMController(
    animationCurve: Curves.bounceInOut,

  );

  void operation() {
    controller.listen(
      observe: (p0, p1) {
        log('     listen $p0       and  $p1');
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    operation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
              onPressed: () {
                controller.setValue(height: 2, pageThreshold: 2.345245);
               // controller.
              },
              child: const Icon(Icons.add)),
          const SizedBox(
            height: 30,
          ),
          ElevatedButton(
              onPressed: () {
                controller.setValue(height: 567, pageThreshold: 324.678);
              },
              child: const Icon(Icons.add)),
        ],
      ),
    );
  }
}
