import 'package:first_project/utils/app_url.dart';
import 'package:first_project/utils/asset_names.dart';
import 'package:first_project/utils/mycolor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTabHeader extends StatelessWidget {
  final TabController controller;
  const CustomTabHeader({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TabBar(
      controller: controller,
      labelStyle: const TextStyle(
          color: MyColor.primaryColor,
          fontFamily: 'Roboto',
          fontSize: 12,
          fontWeight: FontWeight.w500),
      indicatorSize: TabBarIndicatorSize.tab,
      indicator: const UnderlineTabIndicator(
        borderSide: BorderSide(color: MyColor.primaryColor, width: 2.0),
        insets: EdgeInsets.fromLTRB(34.0, 0.0, 34.0, 64.0),
      ),
      unselectedLabelColor: const Color(0xFFc9c9c9),
      unselectedLabelStyle: const TextStyle(
          color: Color(0xFFc9c9c9), fontSize: 12, fontFamily: 'Roboto'),
      tabs:  [
        Tab(
          text: 'My eSIMs',
          icon: Icon(FontAwesomeIcons.simCard),
        ),
        Tab(
          text: 'Store',
          icon: SvgPicture.asset(AssetNames.shoppingSvgIcon, ),
        ),
        Tab(
          text: 'Profile',
          icon: Icon(FontAwesomeIcons.user),
        ),
      ],
    );
  }
}

class GlobalComponent {
  static Text titleText({required String title}) =>  Text(
        title,
        style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Color.fromRGBO(0, 18, 63, 1)),
      );
      static Widget titleButton(Widget child){
          return Container(
            padding: const EdgeInsets.all(8),
            decoration:  BoxDecoration(
              
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xffF3F8FF), width: 2),
            ),
            child: child,
          );
      }


     static AspectRatio bannerStore() =>
     AspectRatio(
            aspectRatio: 1.9,
            child: Container(
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Stack(
                children: <Widget>[
                  Positioned(
                    top: 0,
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Image.network(
                      AppUrl.americaPng,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 16, right: 12, top: 12, bottom: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'OUR AMERICAN\nCONNECTION!',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 22,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Text(
                                  '10Gb',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 22,
                                  ),
                                ),
                                Text(
                                  '/10 euro',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                            ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color.fromRGBO(
                                      255, 255, 255, 0.45)),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Text(
                                    'Buy',
                                    style: GoogleFonts.inter(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white),
                                  ),
                                  const Icon(Icons.arrow_forward,size: 18, color: Colors.white,)
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
  
}
