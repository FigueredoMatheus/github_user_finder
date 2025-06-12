import 'package:github_user_finder/modules/search-user/data/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class UserCacheService {
  static const _userPrefix = 'cached_user_';

  Future<void> cacheUser(UserModel user) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = jsonEncode(user.toJson());
    await prefs.setString('$_userPrefix${user.login}', jsonString);
  }

  Future<UserModel?> getCachedUser(String username) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString('$_userPrefix$username');

    if (jsonString == null) return null;

    try {
      final Map<String, dynamic> jsonMap = jsonDecode(jsonString);
      return UserModel.fromJson(jsonMap);
    } catch (_) {
      return null;
    }
  }
}
