import 'package:flutter/material.dart';
import 'package:github_user_search/models/user_model.dart';
import 'package:github_user_search/repositories/user_repository.dart';

class UserProvider extends ChangeNotifier {
  List<UserModel> users = [];
  UserModel? user;
  List<String> keys = [];
  String errorMessage = '';
  bool isLoading = false;
  TextEditingController searchController = TextEditingController();

  final UserRepository userRepository;

  UserProvider({required this.userRepository});

  Future<void> searchUsers(String query) async {
    isLoading = true;
    notifyListeners();

    try {
      if (query.isEmpty) {
        users = [];
        errorMessage = '';
        isLoading = false;
        notifyListeners();
        return;
      }
      searchController.text = query;
      users = await userRepository.getFilteredUsers(query);
      keys = [];
      errorMessage = '';
    } catch (e) {
      errorMessage = e.toString();
      users = [];
    }
    isLoading = false;
    notifyListeners();
  }

  Future<void> selectedUser(String username) async {
    isLoading = true;
    notifyListeners();

    try {
      user = await userRepository.getUserDetails(username);
      errorMessage = '';
    } catch (e) {
      errorMessage = e.toString();
      user = null;
    }
    isLoading = false;
    notifyListeners();
  }

  Future<void> getKeys() async {
    try {
      keys = await userRepository.getKeys();
      errorMessage = '';
    } catch (e) {
      errorMessage = e.toString();
      keys = [];
    }
    isLoading = false;
    notifyListeners();
  }

  Future<void> deleteKeys(String key) async {
    try {
      await userRepository.deleteKeys(key);
      getKeys();
      errorMessage = '';
    } catch (e) {
      errorMessage = e.toString();
    }
    isLoading = false;
    notifyListeners();
  }
}
