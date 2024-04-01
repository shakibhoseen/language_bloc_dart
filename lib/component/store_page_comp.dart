
import 'package:first_project/utils/mycolor.dart';
import 'package:flutter/material.dart';

class StorePageComponent {
 static Container customAnimatedCard(ValueNotifier<Alignment> valueNotifier, ) {
    return Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
                color: const Color(0xffF3F8FF),
                borderRadius: BorderRadius.circular(100)),
            child: ValueListenableBuilder<Alignment>(
                valueListenable: valueNotifier,
                builder: (context, value, _) {
                  return Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      AnimatedAlign(
                        alignment: value,
                        duration: const Duration(milliseconds: 300),
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 4),
                          height: 45,
                          width: 160,
                          decoration: BoxDecoration(
                            color: MyColor.primaryColor,
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          GestureDetector(
                            onTap: () {
                              valueNotifier.value = Alignment.centerLeft;
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Countries',
                                style: value == Alignment.centerLeft
                                    ? const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500)
                                    : const TextStyle(
                                        color: MyColor.primaryColor,
                                        fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              valueNotifier.value = Alignment.centerRight;
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Regions',
                                style: value == Alignment.centerRight
                                    ?  const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500)
                                    : const TextStyle(
                                        color: MyColor.primaryColor,
                                        fontWeight: FontWeight.w500),
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  );
                }),
          );
  }
}