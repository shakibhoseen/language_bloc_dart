import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';

class MyController{
  final Curve animationCurve;
   double gestureHeight;
  final AnimationController controller;

  MyController({required this.animationCurve, required this.gestureHeight, required TickerProvider vsync, required this.totalPage}): controller = AnimationController(
    vsync: vsync,
    duration: const Duration(seconds: 2),
  );
  final listener = ValueNotifier<(double, double)>((0, 0));

  VoidCallback? _animationListener;
  double _startTapPosition = 0.0, _holdPositionValue = 0.0  ;
  final double totalPage ;
  double _currentPage = 0 , _currentThreshHold =0.0, _valueChangeValue = 0.0;
  bool _needEndCall =false, _needStartCall =false, _blockDragEndCall =false;


  void listenProgress(){
     //listen( _valueChangeValue,  _currentThreshHold);
    listener.value = ( _valueChangeValue,  _currentThreshHold);
  }


  void  onHorizontalDragStart(DragStartDetails details) {
    // Handle drag start event
    controller.stop();
    if (_animationListener != null) {
      controller.removeListener(_animationListener!);
      //myStop = true;
    }
    _startTapPosition = details.localPosition.dy;
    //if(!controller.isCompleted){
    _holdPositionValue = _valueChangeValue;
    // }
    _needEndCall = true;
    _needStartCall = true;

  }


  void onHorizontalDragUpdate(DragUpdateDetails details) {

    final swipe = _startTapPosition.ceilToDouble() - details.localPosition.dy.ceilToDouble();
    final isScrollUp = swipe > 0 ? true: false ;

    ///page behaviour attach
    log('$swipe -----------------');
    if(isScrollUp ){
      log('up');
      //scrollDown --- // swipe up --positive
      final updatePosition = _holdPositionValue - swipe; // indicate scroll down
      double holderThreshToCheck = calculateThreshHold(updatePosition) ;
      if(holderThreshToCheck<totalPage-1 && holderThreshToCheck>=0){
        if(approxEqual(0, _holdPositionValue, 0.1) && _needStartCall){
          _holdPositionValue = gestureHeight - 50;
          _needStartCall = false;
          updatePage(pageIncrease: true);
        }


        if ( updatePosition > 0 && updatePosition < gestureHeight) {
          _valueChangeValue = updatePosition;
        }

        _currentThreshHold = holderThreshToCheck; listenProgress();
        _blockDragEndCall =false;
      }else{
        _blockDragEndCall = true;
      }
    }else if(swipe<0){
      //swipe down
      log('down');
      final updatePosition =
          _holdPositionValue - swipe; // indicate scroll down
      double holderThreshToCheck = calculateThreshHold(updatePosition) ;
      if(holderThreshToCheck>0 && holderThreshToCheck<totalPage-1){
        if(approxEqual(gestureHeight -50, _holdPositionValue, 0.1) && _needEndCall){
          _holdPositionValue = 0;

          //updatePage(value)
          _needEndCall = false;
          updatePage(pageIncrease: false);
        }



        if ( updatePosition > 0 && updatePosition < gestureHeight) {
          _valueChangeValue = updatePosition;
        }

        _currentThreshHold = holderThreshToCheck;
        listenProgress();
        _blockDragEndCall = false;
      }else{
        _blockDragEndCall = true;
      }

    }
    ///end page


  }

  void onHorizontalDragEnd(DragEndDetails details) {
    if(!_blockDragEndCall){
      _handleDragEnd((_valueChangeValue).abs());

    }else{
      if((_valueChangeValue - gestureHeight).abs() > _valueChangeValue.abs()){
        _handleDragEnd(0);
      }else{
        _handleDragEnd(gestureHeight-50);
      }

    }

  }



  void _handleDragEnd(double dy) {
    final double start = dy;

    double end = 0;
    //log(' ${valueChange.value} -value- ${gestureHeight / 2}');
    if (_valueChangeValue > gestureHeight / 2 - 25) {
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
      _valueChangeValue = value;
      //hasReachedEnd = value > 700 ? true : false;
      _holdPositionValue = value;
      // if(value == end && destinationReverse !=end){
      //   if(currentPage>0 && value>0){
      //          currentPage--;
      //   }
      //   if(currentPage<totalPage-1 && value==0){
      //     currentPage++;
      //   }
      //  // currentPage += value>0? -1: 1;
      // }
      // log('$value   -  $end');
      updateThressHold(value);
    };

    controller.addListener(_animationListener!);
  }

  void updatePage({required bool pageIncrease}){
    if(_currentPage>0 && !pageIncrease){
      _currentPage--;
    }
    if(_currentPage<totalPage-1 && pageIncrease){
      _currentPage++;
    }
    log('current ___________----------- $_currentPage');
  }

  void updateThressHold(double value){
    _currentThreshHold = calculateThreshHold(value);
    listenProgress();
  }

  double calculateThreshHold (double value){
    return _currentPage-normalize(value: value, oldMin: 0, oldMax: gestureHeight-50);
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

  bool approxEqual(double a, double b, double tolerance) {
    return (a - b).abs() < tolerance;
  }
}