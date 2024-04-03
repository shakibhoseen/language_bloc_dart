
import 'package:first_project/l10n/app_l10n.dart';
import 'package:first_project/view/custom_page/custom_slide2.dart';
import 'package:first_project/view/custom_page/custom_sliebar.dart';
import 'package:first_project/view/screen/custom_scroll.dart';
import 'package:first_project/view/screen/paint_screen.dart';
import 'package:first_project/view/screen/cubit_screen.dart';
import 'package:first_project/view/screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/counter_cubit.dart';
import 'view/screen/onboarding_screen.dart';

class MyApp extends StatelessWidget {
  final Locale? locale;
  const MyApp({super.key, this.locale});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        fontFamily: 'Poppins',
        
        
      ),

      //language
      locale: locale,
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      //*language
     
      home:
      // BlocProvider(
      //   create: (_) => CounterCubit(),
      //   child: const CubitScreen(),
      // ),
      const CustomSliebar2(),
     //const OnboardingScreen(),
    );
  }
}
