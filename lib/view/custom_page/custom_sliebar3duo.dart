import 'dart:developer';

import 'package:first_project/view/custom_page/controller/my_controller.dart';
import 'package:flutter/material.dart';

class SMControllerWidget extends StatefulWidget {
  const SMControllerWidget({super.key});

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
                    decoration: const BoxDecoration(
                      image: DecorationImage(image: NetworkImage('https://www.foodiesfeed.com/wp-content/uploads/2023/05/exotic-spices.jpg'), fit: BoxFit.cover)
                    ),
                    // Your flip animation widget content
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Shakib', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w600),),
                        SizedBox(height: 20,),
                        Container(
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.black45,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ValueListenableBuilder(
                              valueListenable: myController.listener,
                              builder: (context, value, _) {
                                return Text(
                                  '${value.$2.toStringAsFixed(2)} -- ${value.$2}',
                                  style: const TextStyle(color: Colors.white),
                                );
                              }),
                        ),

                        SizedBox(height: 20,),
                        ValueListenableBuilder(
                          valueListenable: myController.listener,
                          builder: (context, value, _) {
                            return ElevatedButton(onPressed: (){
                              log(' stop = $isStop -- animated =${myController.isAnimating()} completed =${myController.isCompleted()}');
                              if(isStop && !myController.isCompleted()){
                                 log('animation start call');
                                isStop = false; myController.playAnimation();
                              }else if(!isStop && myController.isAnimating()){
                                log('animation stop call');
                                isStop = true;  myController.stopAnimation();
                              }

                            },
                             style: ElevatedButton.styleFrom(
                               padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                               backgroundColor: Colors.deepPurple,
                               shape: RoundedRectangleBorder(
                                 borderRadius: BorderRadius.circular(25),
                               )
                             ),
                              child:  Icon(myController.isAnimating()? Icons.pause:Icons.play_arrow, color: Colors.white,),
                            );
                          }
                        )
                      ],
                    ),
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
                      height:  50,
                      width: 50,
                      padding: EdgeInsets.all(2),
                      clipBehavior: Clip.antiAlias,
                      decoration:  BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.red,
                        border: Border.all(color: Colors.white),
                        boxShadow: [BoxShadow(color: Colors.orange, offset: Offset(3,3), blurRadius: 10)]
                      ),
                      child: Container(
                        clipBehavior: Clip.antiAlias,
                          decoration: const BoxDecoration(shape: BoxShape.circle),
                          child: Image.network('https://www.foodiesfeed.com/wp-content/uploads/2023/12/fruit-popsicles.jpg', fit: BoxFit.cover,)),
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
