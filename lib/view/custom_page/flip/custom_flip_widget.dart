import 'package:first_project/view/custom_page/controller/sm_controller.dart';
import 'package:first_project/view/custom_page/widget/sm_controller_widget.dart';
import 'package:flutter/material.dart';

import 'custom_vertical_flip_page_turn.dart';

class CustomFlipWidget extends StatefulWidget {
  final List<Widget> pages;
  final SMController smController;
  const CustomFlipWidget({super.key, required this.pages, required this.smController});

  @override
  State<CustomFlipWidget> createState() => _CustomFlipWidgetState();
}

class _CustomFlipWidgetState extends State<CustomFlipWidget> {

  late SMController smController ;
  int page = 0;
  CustomVerticalFlipPageTurnController turnController= CustomVerticalFlipPageTurnController();
  @override
  void initState() {
    // TODO: implement initState
    smController = widget.smController;
    smController.listen(observe: (page, pageThreshHold) {
       turnController.animCustom(pageThreshHold, page);
    },);

      //   .addListener(() {
      // //log('viewport- ${controller.viewportFraction} | page-${controller.page}');
      // //log('page- ${controller.page} | offset-${controller.offset}');
      // turnController.animCustom( controller.page??0 ,(controller.page??0).toInt());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Container(
        color: Colors.yellow,
        child: Padding(
          padding: const EdgeInsets.all(0),
          child: LayoutBuilder(builder: (context, constraints) {
            return SMControllerWidget(smController: smController,
                totalPage: widget.pages.length,
                child: CustomVerticalFlipPageTurn(
                  cellSize: Size(constraints.maxWidth, constraints.maxHeight),
                  controller: turnController,
                  children: widget.pages.map((e) => e).toList(),
                ));
          }),
        ),
      ),
    );
  }
}
