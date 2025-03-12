import 'package:github_user_search/models/user_model.dart';

abstract class UserRepository {
  Future<List<UserModel>> getFilteredUsers(String query);
  Future<List<UserModel>> getUsersWithPublicReposMoreThan50(
      List<UserModel> users);
  Future<List<UserModel>> getUsersCommitedInlast6Months(List<UserModel> users);
  Future<List<String>> getKeys();
  Future<void> deleteKeys(String key);
  Future<UserModel> getUserDetails(String username);
}
