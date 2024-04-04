import 'dart:developer';

import 'package:first_project/view/custom_page/controller/sm_controller.dart';
import 'package:first_project/view/custom_page/flip/custom_flip_widget.dart';
import 'package:flutter/material.dart';

class FlipDevelopScreen extends StatelessWidget {
  const FlipDevelopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomFlipWidget(pages: [
          childUi(Colors.red, 'red'),
          childUi(Colors.green, 'green'),
          childUi(Colors.yellowAccent, 'yellow'),
          childUi(Colors.indigo, 'indigo'),
        ],smController: SMController(animationCurve: Curves.bounceInOut,)),

      ),
    );
  }


  Widget childUi(Color color, String title){
    return Container(
      color: color,
      constraints: const BoxConstraints(minHeight: 100, minWidth: 100),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(child: Text(title,), onPressed: (){
              log('press on  $title  call .. ');
            },),
            const SizedBox(height: 5,),
            ElevatedButton(child: Text(title,), onPressed: (){
              log('press on  $title  call .. ');
            },),
            const SizedBox(height: 5,),
            ElevatedButton(child: Text(title,), onPressed: (){
              log('press on  $title  call .. ');
            },),
          ],
        ),
      ),
    );
  }
}
