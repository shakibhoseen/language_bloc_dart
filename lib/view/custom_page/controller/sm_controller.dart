
import 'package:flutter/cupertino.dart';

class SMController {
  //final TickerProvider vsync;
  final Curve animationCurve;
  Duration duration;
  Function(int, double)? _observe;
  ValueNotifier<(double, double)> valueListenable = ValueNotifier<(double height, double thresHold)>((0, 0));

  SMController(
      {required this.animationCurve,
        this.duration = const Duration(seconds: 2)});

  void listen({required Function(int page, double pageThreshHold) observe}) {
    _observe = observe;
  }

  void setValue({required double height, required double pageThreshold}) {
    _observe?.call(pageThreshold.toInt(), pageThreshold);
  }

  Widget build(Widget Function(BuildContext context, double currentThreshold, double height) builder){
    return ValueListenableBuilder(valueListenable: valueListenable, builder: (context, value, child) {
        return builder(context,value.$2, value.$1 );
    },);
  }
}
