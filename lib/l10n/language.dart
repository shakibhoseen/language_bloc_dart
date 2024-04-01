import 'dart:ui';

import '../gen/assets.gen.dart';


enum Language {

  english(
    Locale('en', 'US'),
    Assets.usFlag,
    'English',
  ),
  indonesia(
    Locale('id', 'ID'),
    Assets.indonesiaFlag,
    'Bahasa Indonesia',
  ),
  bangladesh(
    Locale('bn', 'Bd'),
    Assets.indonesiaFlag,
    'বাংলা',
  );

  /// Add another languages support here
  const Language(this.value, this.image, this.text);

  final Locale value;
  final AssetGenImage image; // Optional: this properties used for ListTile details
  final String text; // Optional: this properties used for ListTile details
}