import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';

class CustomSliebar extends StatefulWidget {
  const CustomSliebar({super.key});

  @override
  State<CustomSliebar> createState() => _CustomSliebarState();
}

class _CustomSliebarState extends State<CustomSliebar>
    with SingleTickerProviderStateMixin {
  final valueChange = ValueNotifier<double>(0);
  double gestureHeight = 0.0;
  late AnimationController controller;
  double startTapPosition = 0.0;
  double holdPositionValue = 0.0;
  bool hasReachedEnd = false;

  @override
  void initState() {
    // TODO: implement initState
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              left: 0,
              right: 0,
              top: 0,
              bottom: 0,
              child: GestureDetector(
                onHorizontalDragStart: (details) {
                  // Handle drag start event
                  startTapPosition = details.localPosition.dy;
                },
                onHorizontalDragUpdate: (details) {
                  final swipe = startTapPosition - details.localPosition.dy;
                  final isScrollDown = swipe > 0 ? false : true;
                  //log('(${swipe} -- ${isScrollDown}) ');
                  if (hasReachedEnd) {
                    if (!isScrollDown) {
                      valueChange.value = holdPositionValue - swipe;
                    }
                  } else if (isScrollDown) {
                    valueChange.value = (swipe).abs();
                  }
                },
                onHorizontalDragEnd: (details) {
                  _handleDragEnd((valueChange.value).abs());
                },
                child: LayoutBuilder(builder: (context, constraint) {
                  gestureHeight = constraint.maxHeight;
                  return Container(
                    color: Colors.white,
                    // Your flip animation widget content
                    child: Center(
                        child: Text(
                      '${constraint.maxHeight} -- ${constraint.minHeight}',
                    )),
                  );
                }),
              ),
            ),
            ValueListenableBuilder(
                valueListenable: valueChange,
                builder: (context, value, _) {
                  return Positioned(
                    top: value,
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.red,
                      ),
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }

  // Stream<double> generateValues(Duration duration, double start, double end, {Curve curve = Curves.linear}) async* {
  //
  //
  //   final animation = CurvedAnimation(parent: controller, curve: curve);
  //
  //   controller.forward();
  //   double value = start;
  //   final startTime = DateTime.now();
  //   while ( value>1 ) {   //DateTime.now().difference(startTime) < duration
  //      value = lerpDouble(start, end, animation.value)!;
  //     yield value;
  //     await Future<void>.delayed(const Duration(milliseconds: 6)); // Adjust as needed
  //   }
  //   controller.reverse();
  //
  //   //controller.dispose();
  // }

  void _handleDragEnd(double dy) {
    final double start = dy;

    double end = 0;
    log(' ${valueChange.value} -value- ${gestureHeight / 2}');
    if (valueChange.value > gestureHeight / 2 - 25) {
      end = gestureHeight - 50;
    }
    holdPositionValue = end;
    controller.value = 0; // Reset the animation to start from the beginning
    controller.animateTo(
      1,
      curve: Curves.easeInOut,
      duration: const Duration(milliseconds: 1000),
    );

    controller.addListener(() {
      final double value = lerpDouble(start, end, controller.value)!;
      valueChange.value = value;
      hasReachedEnd = value > 700 ? true : false;
    });
  }
}
