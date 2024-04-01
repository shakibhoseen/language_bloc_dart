
part of 'language_bloc.dart';

abstract class LanguageEvent  {
  const LanguageEvent();
}

class ChangeLanguage extends LanguageEvent {
  const ChangeLanguage({required this.selectedLanguage});
  final Language selectedLanguage;

}
class GetLanguage extends LanguageEvent {}