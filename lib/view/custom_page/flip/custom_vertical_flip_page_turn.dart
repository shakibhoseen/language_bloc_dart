
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomVerticalFlipPageTurn extends StatefulWidget {
  CustomVerticalFlipPageTurn({
    Key? key,
    required this.children,
    required this.controller,
    required this.cellSize,
  }) : super(key: key);

  final List<Widget> children;

  final Size cellSize;

  final CustomVerticalFlipPageTurnController controller;

  @override
  CustomVerticalFlipPageTurnState createState() => CustomVerticalFlipPageTurnState();
}
class Opp{
  double value;
  Opp(this.value);
}
class CustomVerticalFlipPageTurnState extends State<CustomVerticalFlipPageTurn>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
   Opp _animation = Opp(0);
  ValueNotifier<(double, int)> valueNotifier = ValueNotifier((0,0));
  int myPageIndex=0;
  int position = 0;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(vsync: this);
    // _animation = _animationController
    //     .drive(Tween(begin: 0.0, end: widget.children.length - 1));

    //_animation = Tween<double>(begin: 0.0, end:  widget.children.length - 1).animate(_animationController);

    widget.controller._toLeftCallback = (duration) {
      if (position > 0) {
        position = position - 1;
        _animationController.animateTo(position / (widget.children.length - 1),
            duration: duration);
      }
    };

    widget.controller._toRightCallback = (duration) {
      if (position < widget.children.length - 1) {
        position = position + 1;
        _animationController.animateTo(position / (widget.children.length - 1),
            duration: duration);
      }
    };

    widget.controller._animCustomCallBack = (value){
      //_animation = position;
      //_animationController.value = value.$1-value.$2;
      //_animation.value = value.$1-value.$2;
      //_animationController.animateTo(value.$1);

      // if(myPageIndex!=value.$2){
      //   _animationController.reset();
      //   myPageIndex = value.$2;
      // }
      valueNotifier.value = (value.$1, value.$2 );
      valueNotifier.notifyListeners();
      // Trigger a rebuild to update the UI
      // if (_animationController.status != AnimationStatus.forward) {
      //   _animationController.forward(from: position);
      // }
    };

    // widget.controller._toPositionCallback = (position, duration) {
    //   if (position >= 0 && position <= widget.children.length - 1) {
    //     _animationController.animateTo(position / (widget.children.length - 1),
    //         duration: duration * (position - this.position).abs());
    //     this.position = position;
    //   }
    // };
  }

  @override
  void didUpdateWidget(covariant CustomVerticalFlipPageTurn oldWidget) {
    super.didUpdateWidget(oldWidget);
    // _animation = _animationController
    //     .drive(Tween(begin: 0.0, end: widget.children.length - 1));
    if (this.position > widget.children.length - 1) {
      this.position = widget.children.length - 1;
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<(double, int)>(
      valueListenable: valueNotifier,
      builder: (context, value, child) {
        _animation.value = (value.$1-value.$2).abs();
        //d.log('port- ${value.$1} | page-${value.$2}');
        final angle = (_animation.value - _animation.value ~/ 1) * pi ;
        final maskOpacity = _animation.value - _animation.value ~/ 1;
        final cellWidth = widget.cellSize.width;
        final cellHeight = widget.cellSize.height;
        //d.log('build angel-$angle | anim=${_animation.value} |mask=$maskOpacity');
        return SizedBox(
          width: cellWidth,
          height: cellHeight,
          child: Stack(
            children: <Widget>[
              Offstage(
                offstage: !(angle >= pi / 2),
                child: Container(
                  width: cellWidth,
                  height: cellHeight,
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: ClipRect(
                      child: Align(
                        heightFactor: 0.5,
                        alignment: Alignment.topCenter,
                        child: getTopWidget(),
                      ),
                    ),
                  ),
                ),
              ),
              Offstage(
                offstage: angle == 0,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: cellWidth,
                    height: cellHeight/2,
                    child: OverflowBox(
                      minHeight: cellHeight/2,
                      maxHeight: cellHeight,
                      child: ClipRect(
                        child: Align(
                          heightFactor: 0.5,
                          alignment: Alignment.bottomCenter,
                          child: getBottomWidget(),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Offstage(
                offstage: !(angle >= pi / 2),
                child: Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.0001)
                    ..rotateX(angle),
                  child: Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.rotationX(pi),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        width: cellWidth,
                        height: cellHeight/2,
                        child: OverflowBox(
                          minHeight: cellHeight / 2,
                          maxHeight: cellHeight,
                          child: ClipRect(
                            child: Align(
                              heightFactor: 0.5,
                              alignment: Alignment.topCenter,
                              child: Stack(
                                children: [
                                  getBottomWidget() ?? SizedBox(),
                                  if (getBottomWidget() != null)
                                    Offstage(
                                      offstage: 1 - maskOpacity == 0,
                                      child: Container(
                                        color: Colors.black12
                                            .withOpacity(1 - maskOpacity),
                                        constraints: BoxConstraints.expand(),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Offstage(
                offstage: angle >= pi / 2,
                child: Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.0001)
                    ..rotateX(angle),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      width: angle >= pi / 2 ? 0.0 : cellWidth ,
                      height: angle >= pi / 2 ? 0.0 : cellHeight/2,
                      child: OverflowBox(
                        minHeight: cellHeight / 2,
                        maxHeight: cellHeight,
                        child: ClipRect(
                          child: Align(
                            heightFactor: 0.5,
                            alignment: Alignment.bottomCenter,
                            child: Stack(
                              children: [
                                getTopWidget(),
                                Offstage(
                                  offstage: maskOpacity == 0,
                                  child: Container(
                                    color:
                                        Colors.black12.withOpacity(maskOpacity),
                                    constraints: BoxConstraints.expand(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Offstage(
                offstage: angle >= pi / 2,
                child: Container(
                  width: cellWidth,
                  height: cellHeight,
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: ClipRect(
                      child: Align(
                        heightFactor: 0.5,
                        alignment: Alignment.topCenter,
                        child: getTopWidget(),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget getTopWidget() {
    if ( valueNotifier.value.$2.toInt()>=0) {
      return widget.children[valueNotifier.value.$2.toInt()];
    }
    return widget.children[0];
  }

  Widget? getBottomWidget() {
    if (valueNotifier.value.$2.toInt() < widget.children.length - 1) {
      return widget.children[valueNotifier.value.$2.toInt() + 1];
    }
  }
}

class CustomVerticalFlipPageTurnController {
  ValueChanged<Duration>? _toLeftCallback;

  ValueChanged<Duration>? _toRightCallback;
  ValueChanged<(double, int)>? _animCustomCallBack;

  void Function(int, Duration)? _toPositionCallback;

  void animToLeftWidget(
      {Duration duration = const Duration(milliseconds: 350)}) {
    if (_toLeftCallback != null) {
      _toLeftCallback!(duration);
    }
  }

  void animToRightWidget(
      {Duration duration = const Duration(milliseconds: 350)}) {
    if (_toRightCallback != null) {
      _toRightCallback!(duration);
    }
  }

  void animToPositionWidget(int position,
      {Duration duration = const Duration(milliseconds: 350)}) {
    if (_toPositionCallback != null) {
      _toPositionCallback!(position, duration);
    }
  }
  void animCustom(double position, int page){
    if (_animCustomCallBack != null) {
      _animCustomCallBack!((position, page));
    }
  }
}
