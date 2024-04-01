import 'package:first_project/app.dart';
import 'package:first_project/bloc/language_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(BlocProvider(
    create: (_) => LanguageBloc()..add(GetLanguage()),
    child: BlocBuilder<LanguageBloc, LanguageState>(
      builder: (context, language) {
        return  MyApp(locale: language.selectedLanguage.value,);
      }
    ),
  ));
}
