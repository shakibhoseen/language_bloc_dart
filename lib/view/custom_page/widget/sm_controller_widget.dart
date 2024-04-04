
import 'package:first_project/view/custom_page/controller/my_controller.dart';
import 'package:flutter/material.dart';

import '../controller/sm_controller.dart';

class SMControllerWidget extends StatefulWidget {
  final SMController smController;
  final Widget child;
  final int totalPage;

  const SMControllerWidget(
      {super.key,
      required this.smController,
      required this.child,
      required this.totalPage});

  @override
  State<SMControllerWidget> createState() => _SMControllerWidgetState();
}

class _SMControllerWidgetState extends State<SMControllerWidget>
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
      widget.smController.valueListenable.value =myController.listener.value;
      widget.smController.setValue(
          height: myController.listener.value.$1,
          pageThreshold: myController.listener.value.$2);
    });

  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onHorizontalDragStart: myController.onHorizontalDragStart,
        onHorizontalDragUpdate: myController.onHorizontalDragUpdate,
        onHorizontalDragEnd: myController.onHorizontalDragEnd,
        child: LayoutBuilder(builder: (context, constraint) {
          myController.gestureHeight = constraint.maxHeight;
          return widget.child;
        }),);
  }
}
