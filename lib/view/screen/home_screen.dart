
import 'package:first_project/component/home_screen_comp.dart';
import 'package:first_project/view/page/profile_page.dart';
import 'package:first_project/view/page/sim_page.dart';
import 'package:first_project/view/page/store_page.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key,});

 
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  
  late TabController controller;

  @override
  void initState() {
   
    controller = TabController(length: 3, vsync: this);
    super.initState();
  }

  
  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      
      bottomNavigationBar: CustomTabHeader(controller: controller),
      body: TabBarView(
        controller: controller,
        children:  <Widget>[
         const SimPage(),
         StorePage(),
         const ProfilePage()
        ],
      ),
    );
  }
}
