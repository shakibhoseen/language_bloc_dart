import 'package:first_project/view/custom_page/controller/my_controller.dart';
import 'package:flutter/material.dart';

class CustomSliebar3 extends StatefulWidget {
  const CustomSliebar3({super.key});

  @override
  State<CustomSliebar3> createState() => _CustomSliebar3State();
}

class _CustomSliebar3State extends State<CustomSliebar3>
    with SingleTickerProviderStateMixin {
  late MyController myController;
  double threshHold = 0.0;

  @override
  void initState() {
    // TODO: implement initState
    myController = MyController(
        animationCurve: Curves.bounceInOut,
        gestureHeight: 10,
        vsync: this,
      totalPage: 10
    );
    super.initState();
  }

  void listen(double animationValue, double threshHold) {
    //valueChange.value = animationValue;
    this.threshHold = threshHold;
  }

  void changesValueFrom(){
    //myController.listener.l
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
                onHorizontalDragStart: myController.onHorizontalDragStart,
                onHorizontalDragUpdate: myController.onHorizontalDragUpdate,
                onHorizontalDragEnd: myController.onHorizontalDragEnd,
                child: LayoutBuilder(builder: (context, constraint) {
                  myController.gestureHeight = constraint.maxHeight;
                  return Container(
                    color: Colors.white,
                    // Your flip animation widget content
                    child: Center(
                        child: ValueListenableBuilder(
                            valueListenable: myController.listener,
                            builder: (context, value, _) {
                              return Text(
                                '${value.$1} -- ${value.$2}',
                              );
                            })),
                  );
                }),
              ),
            ),
            ValueListenableBuilder(
                valueListenable: myController.listener,
                builder: (context, value, _) {
                  return Positioned(
                    top: value.$1,
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
}
