import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '';
import '../l10n/language.dart';

part 'language_state.dart';

part 'language_event.dart';

const languagePrefsKey = 'languagePrefs';

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  LanguageBloc() : super(const LanguageState()) {
    on<ChangeLanguage>(onChangeLanguage);
     on<GetLanguage>(onGetLanguage);

  }

  onGetLanguage(GetLanguage event,Emitter<LanguageState> emit) async {
    final prefs = await SharedPreferences.getInstance();
    final languageCode = prefs.getString(languagePrefsKey);
    emit(state.copyWith(selectedLanguage: languageCode!=null ? Language.values.where((element) => languageCode == element.value.languageCode,).first : Language.english) );
  }

  onChangeLanguage(ChangeLanguage event, Emitter<LanguageState> emit) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      languagePrefsKey,
      event.selectedLanguage.value.languageCode,
    );
    emit(state.copyWith(selectedLanguage: event.selectedLanguage));
  }
}
