import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_player/domain/repositories/theme_repository.dart';

class ThemeRepositoryImpl implements ThemeRepository {
  final SharedPreferences sharedPreferences;

  ThemeRepositoryImpl({required this.sharedPreferences});

  @override
  Future<bool> isDarkMode() async {
    return sharedPreferences.getBool('isDarkMode') ?? false;
  }

  @override
  Future<void> setDarkMode(bool isDarkMode) async {
    await sharedPreferences.setBool('isDarkMode', isDarkMode);
  }
}
