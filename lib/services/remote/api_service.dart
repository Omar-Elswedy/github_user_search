import 'dart:convert';
import 'package:github_user_search/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'package:github_user_search/models/user_model.dart';

class ApiService {
  Future<List<UserModel>> getUsers(String query) async {
    try {
      http.Response response = await http
          .get(Uri.parse('${AppConst.baseUrl}/search/users?q=$query'));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return (data['items'] as List)
            .map((user) => UserModel.fromJson(user))
            .toList();
      } else {
        return [];
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<UserModel> getUserDetails(String username) async {
    try {
      http.Response response =
          await http.get(Uri.parse('${AppConst.baseUrl}/users/$username'));
      if (response.statusCode == 200) {
        return UserModel.fromJson(jsonDecode(response.body));
      } else {
        throw Exception(
            'Failed to load user details: Status code ${response.statusCode}');
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
