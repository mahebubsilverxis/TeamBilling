
import '../configs/language.dart';

class UtilLanguage {
  ///Get Language Global Language Name
  static String getGlobalLanguageName(String code) {
    switch (code) {
      case 'en':
        return 'English';
      case 'de':
        return 'German';
      default:
        return 'English';
    }
  }

  static bool isRTL() {
    switch (AppLanguage.defaultLanguage.languageCode) {
      case "en":
      case "de":
        return true;
      default:
        return false;
    }
  }

  ///Singleton factory
  static final UtilLanguage _instance = UtilLanguage._internal();

  factory UtilLanguage() {
    return _instance;
  }

  UtilLanguage._internal();
}
