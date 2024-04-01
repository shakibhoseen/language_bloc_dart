import 'package:first_project/bloc/language_bloc.dart';
import 'package:first_project/gen/assets.gen.dart';
import 'package:first_project/l10n/app_l10n.dart';
import 'package:first_project/l10n/language.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  void showLanguageBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                AppLocalizations.of(context)!.chooseLanguage,
                style: Theme.of(context).textTheme.headline2,
              ),
              const SizedBox(height: 16.0),
              BlocBuilder<LanguageBloc, LanguageState>(
                builder: (context, state) {
                  return ListView.separated(
                    shrinkWrap: true,
                    itemCount: Language.values.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        onTap: () {
                          // # 1
                          // Trigger the ChangeLanguage event
                          context.read<LanguageBloc>().add(
                            ChangeLanguage(
                              selectedLanguage: Language.values[index],
                            ),
                          );
                          Future.delayed(const Duration(milliseconds: 300))
                              .then((value) => Navigator.of(context).pop());
                        },
                        leading: ClipOval(
                          child: Language.values[index].image.image(
                            height: 32.0,
                            width: 32.0,
                          ),
                        ),
                        title: Text(Language.values[index].text),
                        trailing:
                        Language.values[index] == state.selectedLanguage
                            ? Icon(
                          Icons.check_circle_rounded,
                          color: ColorsLib.primary,
                        )
                            : null,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          side: Language.values[index] == state.selectedLanguage
                              ? BorderSide(color: ColorsLib.primary, width: 1.5)
                              : BorderSide(color: Colors.grey[300]!),
                        ),
                        tileColor:
                        Language.values[index] == state.selectedLanguage
                            ? ColorsLib.primary.withOpacity(0.05)
                            : null,
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(height: 16.0);
                    },
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: false,
        title: Assets.images.frontVector.image(height: 32.0),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            child: OutlinedButton(
              onPressed: () => showLanguageBottomSheet(context), // #2 Function call
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.all(8.0),
                foregroundColor: ColorsLib.lightGrey,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              child: Row(
                children: [
                  ClipOval(
                    child: BlocBuilder<LanguageBloc, LanguageState>(
                      builder: (context, state) {
                        return state.selectedLanguage.image.image();
                      },
                    ),
                  ),
                  Icon(
                    Icons.arrow_drop_down_rounded,
                    color: ColorsLib.darkPrimary,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
           // Expanded(child: Assets.onboarding.svg()),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.onboarding,
                    style: Theme.of(context).textTheme.headline1,
                  ),
                  const SizedBox(height: 32.0),
                  ElevatedButton(
                    onPressed: () {}, // Assuming l10n provides the translated text
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue, // Or customize styling as needed
                    ),
                    child: Text(l10n.getStarted),
                  ),
                  const SizedBox(height: 8.0),
                  TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.black, // Or customize styling as needed
                    ),
                    child: Text(l10n.haveAccount),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ColorsLib {
  static Color primary = const Color(0xFFFF6124);
  static Color primaryDarker = const Color(0xFFCE5728);
  static Color darkPrimary = const Color(0xFF1D2027);
  static Color blueGreyPrimary = const Color(0xFF819399);
  static Color blueGreySecondary = const Color(0xFFADC4CB);
  static Color lightGrey = const Color(0xFFF1F5F9);
}
