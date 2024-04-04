import 'package:first_project/view/custom_page/controller/sm_controller.dart';
import 'package:flutter/material.dart';

import '../controller/my_controller.dart';

class SMControllerBuilder extends StatefulWidget {
  final SMController smController;
  final Widget Function(
      BuildContext context, double currentThreshold, int currentPage) builder;
  final int totalPage;
  final bool buildWhen;
  const SMControllerBuilder(
      {super.key, required this.smController, required this.builder, required this.totalPage, this.buildWhen = true});

  @override
  State<SMControllerBuilder> createState() => _SMControllerBuilderState();
}

class _SMControllerBuilderState extends State<SMControllerBuilder>
    with SingleTickerProviderStateMixin {
  late MyController myController;
  double threshHold = 0.0;
  bool isStop = false;

  @override
  void initState() {
    // TODO: implement initState
    myController = MyController(
        animationCurve: widget.smController.animationCurve,
        gestureHeight: 10,
        vsync: this,
        totalPage: widget.totalPage.toDouble(),
        duration: widget.smController.duration);
    super.initState();
    myController.listener.addListener(() {
      widget.smController.valueListenable.value = myController.listener.value;
      widget.smController.setValue(
          height: myController.listener.value.$1,
          pageThreshold: myController.listener.value.$2);
    });
  }


  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onHorizontalDragStart: myController.onHorizontalDragStart,
      onHorizontalDragUpdate: myController.onHorizontalDragUpdate,
      onHorizontalDragEnd: myController.onHorizontalDragEnd,
      child: LayoutBuilder(builder: (context, constraint) {
        myController.gestureHeight = constraint.maxHeight;
        return widget.buildWhen ? ValueListenableBuilder(
            valueListenable: myController.listener,
            builder: (context, value, _) {
              return widget.builder( context,    value.$2 ,value.$2.toInt(),);
            }
        ): widget.builder( context,    0 , 0,);
      }),
    );
  }
}