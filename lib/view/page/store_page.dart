import 'package:first_project/component/home_screen_comp.dart';
import 'package:first_project/component/store_page_comp.dart';
import 'package:first_project/utils/mycolor.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StorePage extends StatelessWidget {
  StorePage({super.key});
  final valueNotifier = ValueNotifier<Alignment>(Alignment.centerLeft);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GlobalComponent.titleButton(
                    const Icon(Icons.monetization_on_outlined)),
                GlobalComponent.titleText(title: 'Select a Package'),
                GlobalComponent.titleButton(
                    const Icon(Icons.notifications_none)),
              ],
            ),
            const SizedBox(
              height: 24,
            ),
            GlobalComponent.bannerStore(),
            const SizedBox(
              height: 24,
            ),
            StorePageComponent.customAnimatedCard(valueNotifier),
            const SizedBox(
              height: 24,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: const Color(0xffC1D0E7))),
              child: Row(
                children: <Widget>[
                  const Icon(Icons.search),
                  const SizedBox(
                    width: 6,
                  ),
                  const SizedBox(
                    height: 18,
                    child: VerticalDivider(
                      thickness: 2,
                      color: MyColor.primaryColor,
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      
                      decoration: InputDecoration(
                        hintText: 'Where do you need internet?',
                        hintStyle: GoogleFonts.inter(),
                        border: InputBorder.none
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}



/* 
TextField(
              
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(color: Color(0xffC1D0E7)),
                ),
                prefixIcon: Icon(Icons.search),
                hintText: 'Where do you need internet?',
                hintStyle: GoogleFonts.inter()
              )
            )
*/