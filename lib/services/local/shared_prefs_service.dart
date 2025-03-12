import 'dart:convert';

import 'package:github_user_search/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsService {
  static late SharedPreferences _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<void> saveUsers(String query, List<UserModel> users) async {
    try {
      final jsonUsers = users.map((user) => user.toJson()).toList();
      await _prefs.setStringList(
          query, jsonUsers.map((json) => jsonEncode(json)).toList());
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<UserModel>> getUsers(String query) async {
    try {
      final jsonUsers = _prefs.getStringList(query);
      if (jsonUsers == null || jsonUsers.isEmpty) return [];
      return jsonUsers
          .map((json) => UserModel.fromJson(jsonDecode(json)))
          .toList();
    } catch (e) {
      throw Exception(e);
    }
  }

  // Future<UserModel> getUserDetails(String username) async {
  //   try {
  //     List<UserModel> userModel = await getUsers(username);
  //     return userModel.firstWhere((element) => element.login == username);
  //   } catch (e) {
  //     throw Exception(e);
  //   }
  // }

  Future<List<String>> getKeys() async {
    try {
      Set<String> keys = _prefs.getKeys();
      if (keys.isEmpty) return [];
      return keys.toList();
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<void> deleteKeys(String key) async {
    try {
      _prefs.remove(key);
    } catch (e) {
      throw Exception(e);
    }
  }
}
