import 'package:first_project/view/custom_page/controller/sm_controller.dart';
import 'package:first_project/view/custom_page/widget/sm_controller_widget.dart';
import 'package:first_project/view/custom_page/widget/sm_controller_builder.dart';
import 'package:flutter/material.dart';

import '../../utils/asset_names.dart';

class DevelopScreen extends StatelessWidget {
  DevelopScreen({super.key});

  final smController = SMController(animationCurve: Curves.decelerate);

  void op() {
    smController.listen(
      observe: (page, pageThreshHold) {},
    );
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
              child: SMControllerWidget(
                smController: smController,
                totalPage: 10,
                child: Container(
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(AssetNames.backgroundWebp),
                          fit: BoxFit.cover)),
                  // Your flip animation widget content
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Shakib',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.black45,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: smController.build(
                              (context, currentThreshold, currentPage) => Text(
                                    '$currentPage -- $currentThreshold',
                                    style: const TextStyle(color: Colors.white),
                                  ))),
                      const SizedBox(
                        height: 20,
                      ),
                      // ElevatedButton(
                      //   onPressed: () {
                      //     log(' stop = $isStop -- animated =${myController.isAnimating()} completed =${myController.isCompleted()}');
                      //     if (isStop && !myController.isCompleted()) {
                      //       log('animation start call');
                      //       isStop = false;
                      //       myController.playAnimation();
                      //     } else if (!isStop &&
                      //         myController.isAnimating()) {
                      //       log('animation stop call');
                      //       isStop = true;
                      //       myController.stopAnimation();
                      //     }
                      //   },
                      //   style: ElevatedButton.styleFrom(
                      //       padding: const EdgeInsets.symmetric(
                      //           horizontal: 12, vertical: 8),
                      //       backgroundColor: Colors.deepPurple,
                      //       shape: RoundedRectangleBorder(
                      //         borderRadius: BorderRadius.circular(25),
                      //       )),
                      //   child: Icon(
                      //     myController.isAnimating()
                      //         ? Icons.pause
                      //         : Icons.play_arrow,
                      //     color: Colors.white,
                      //   ),
                      // )
                    ],
                  ),
                ),
              ),
            ),
            smController.build((context, currentThreshold, height) => Positioned(
              top: height,
              child: Container(
                height: 50,
                width: 50,
                padding: EdgeInsets.all(2),
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.red,
                    border: Border.all(color: Colors.white),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.orange,
                          offset: Offset(3, 3),
                          blurRadius: 10)
                    ]),
                child: Container(
                    clipBehavior: Clip.antiAlias,
                    decoration:
                    const BoxDecoration(shape: BoxShape.circle),
                    child: Image.asset(
                      AssetNames.fruitWebp,
                      fit: BoxFit.cover,
                    )),
              ),
            ),)
          ],
        ),
      ),
    );
  }
}
