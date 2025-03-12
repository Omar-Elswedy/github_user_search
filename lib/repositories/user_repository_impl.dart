import 'package:github_user_search/models/user_model.dart';
import 'package:github_user_search/repositories/user_repository.dart';
import 'package:github_user_search/services/local/shared_prefs_service.dart';
import 'package:github_user_search/services/remote/api_service.dart';

class UserRepositoryImpl implements UserRepository {
  final ApiService apiService;

  UserRepositoryImpl({required this.apiService});

  @override
  Future<List<UserModel>> getFilteredUsers(String query) async {
    List<UserModel> users = [];
    try {
      final cachedUsers = await SharedPrefsService().getUsers(query);
      if (cachedUsers.isNotEmpty) {
        return cachedUsers;
      }
      users = await apiService.getUsers(query);
      users = users.take(10).toList();
      users = await getUsersWithPublicReposMoreThan50(users);
      users = await getUsersCommitedInlast6Months(users);
      await SharedPrefsService().saveUsers(query, users);
      return users;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<List<UserModel>> getUsersWithPublicReposMoreThan50(
      List<UserModel> users) async {
    List<UserModel> userDetails = [];
    try {
      userDetails = await Future.wait(
        users.map(
          (user) => apiService.getUserDetails(user.login!),
        ),
      );
      userDetails = userDetails
          .where((element) => element.publicRepos! > 50)
          .toList()
        ..sort((a, b) => b.publicRepos!.compareTo(a.publicRepos!));
      return userDetails;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<List<UserModel>> getUsersCommitedInlast6Months(
      List<UserModel> users) async {
    try {
      users = users
          .where((element) => element.updatedAt!
              .isAfter(DateTime.now().subtract(const Duration(days: 180))))
          .toList()
        ..sort((a, b) => b.updatedAt!.compareTo(a.updatedAt!));
      return users;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<UserModel> getUserDetails(String username) async {
    try {
      return await apiService.getUserDetails(username);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<List<String>> getKeys() async {
    try {
      List<String> keys = await SharedPrefsService().getKeys();
      return keys.take(10).toList();
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> deleteKeys(String key) async {
    try {
      await SharedPrefsService().deleteKeys(key);
    } catch (e) {
      throw Exception(e);
    }
  }
}
