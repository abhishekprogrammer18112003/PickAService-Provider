import 'package:pick_a_service/core/app_imports.dart';
import 'package:pick_a_service/core/managers/shared_preference_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageChangeProvider with ChangeNotifier {
  Locale? _appLocale;
  Locale? get appLocale => _appLocale;

  void changeLanguage(Locale type) async {
  
    SharedPreferences sp = await SharedPreferences.getInstance();
    _appLocale = type;
    if (type == Locale('en')) {
      await sp.setString('lang', 'en');
    } else {
      await sp.setString('lang', 'ar');
    }
    notifyListeners();
  }
}
