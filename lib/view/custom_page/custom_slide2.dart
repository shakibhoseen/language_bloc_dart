import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';

class CustomSliebar2 extends StatefulWidget {
  const CustomSliebar2({super.key});

  @override
  State<CustomSliebar2> createState() => _CustomSliebar2State();
}

class _CustomSliebar2State extends State<CustomSliebar2>
    with SingleTickerProviderStateMixin {
  final valueChange = ValueNotifier<double>(0);
  double gestureHeight = 0.0;
  late AnimationController controller;
  double startTapPosition = 0.0;
  double holdPositionValue = 0.0 , destinationReverse = 0.0;
  bool hasReachedEnd = false, myStop = false, needEndCall =false, isDragging=false;
  VoidCallback? _animationListener;

  double totalPage = 10.0;
  double currentPage = 3;

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
                  isDragging=true;
                  controller.stop();
                  if (_animationListener != null) {
                    controller.removeListener(_animationListener!);
                    myStop = true;
                  }
                  startTapPosition = details.localPosition.dy;
                  //if(!controller.isCompleted){
                    holdPositionValue = valueChange.value;
                 // }

                },
                onHorizontalDragUpdate: (details) {
                  if(!isDragging) return;
                  final swipe = startTapPosition.ceilToDouble() - details.localPosition.dy.ceilToDouble();
                  final isScrollUp = swipe > 0 ? true: false ;
                  //log('(${swipe} -- ${isScrollDown}) ');
                  // if (hasReachedEnd) {
                  //   if (!isScrollDown) {
                  //     valueChange.value = gestureHeight - swipe;
                  //   }
                  // } else if (isScrollDown) {
                  //   valueChange.value = (swipe).abs();
                  // }
                  ///page behaviour attach
                  log('$swipe -----------------');
                  if(isScrollUp ){
                    log('up');
                    //scrollUp --- // swipe down --positive
                    if(currentPage<totalPage-1 && currentPage>=0){
                      if(holdPositionValue == 0){
                        holdPositionValue = gestureHeight - 50;
                        destinationReverse = holdPositionValue;
                      }

                      final updatePosition =
                          holdPositionValue - swipe; // indicate scroll down
                      if ( updatePosition > 0 && updatePosition < gestureHeight) {
                        valueChange.value = updatePosition;
                      }
                      needEndCall = true;
                    }
                  }else if(swipe<0){
                    //scrollDown
                    log('down');
                    if(currentPage>0 && currentPage<=totalPage-1){
                      if(holdPositionValue ==gestureHeight -50 ){
                        holdPositionValue = 0;
                        destinationReverse = 0;
                        //updatePage(value)
                      }


                      final updatePosition =
                          holdPositionValue - swipe; // indicate scroll down
                      if ( updatePosition > 0 && updatePosition < gestureHeight) {
                        valueChange.value = updatePosition;
                      }
                      needEndCall = true;
                    }

                  }
                  ///end page


                },
                onHorizontalDragEnd: (details) {
                  if(needEndCall){
                    _handleDragEnd((valueChange.value).abs());
                    needEndCall = false;
                  }
                 isDragging =false;
                },
                child: LayoutBuilder(builder: (context, constraint) {
                  gestureHeight = constraint.maxHeight;
                  return Container(
                    color: Colors.white,
                    // Your flip animation widget content
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(onPressed: (){
                          log('press happen');
                        },
                            icon: Icon(Icons.add)),
                        Center(
                          child: ValueListenableBuilder(
                              valueListenable: valueChange,
                              builder: (context, value, _) {

                                //final p = normalize(value: value, oldMax: gestureHeight-50, oldMin: 0);
                                return Text('$currentPage');
                              }),
                        ),
                      ],
                    ),
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
    //log(' ${valueChange.value} -value- ${gestureHeight / 2}');
    if (valueChange.value > gestureHeight / 2 - 25) {
      end = gestureHeight - 50;
    }

    controller.value = 0; // Reset the animation to start from the beginning
    controller.animateTo(
      1,
      curve: Curves.easeInOut,
      duration: const Duration(milliseconds: 1000),
    );

    _animationListener = () {
      final double value = lerpDouble(start, end, controller.value)!;
      valueChange.value = value;
      //hasReachedEnd = value > 700 ? true : false;
      holdPositionValue = value;
      if(value == end && destinationReverse !=end){
        if(currentPage>0 && value>0){
               currentPage--;
        }
        if(currentPage<totalPage-1 && value==0){
          currentPage++;
        }
       // currentPage += value>0? -1: 1;
      }
      // log('$value   -  $end');
    };

    controller.addListener(_animationListener!);
  }

  void updatePage(double value){
    currentPage += value;//normalize(value: value, oldMin: 0, oldMax: gestureHeight-50);
    log('current ___________----------- $currentPage');
  }

  double normalize(
      {required double value,
        required double oldMin,
        required double oldMax,
        double newMin = 0,
        double newMax = 1}) {
    if (oldMin == oldMax) {
      return 0;
      //throw ArgumentError('Old minimum and maximum cannot be equal.');
    }
    return (value - oldMin) / (oldMax - oldMin) * (newMax - newMin) + newMin;
  }
}
