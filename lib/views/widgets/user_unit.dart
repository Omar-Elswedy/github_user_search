import 'package:flutter/material.dart';
import 'package:github_user_search/models/user_model.dart';
import 'package:github_user_search/providers/user_provider.dart';
import 'package:github_user_search/views/screens/user_details_screen.dart';
import 'package:provider/provider.dart';

class UserUnit extends StatelessWidget {
  const UserUnit({
    super.key,
    required this.user,
  });

  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Provider.of<UserProvider>(context, listen: false)
            .selectedUser(user.login ?? '');
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => UserDetailsScreen(user: user),
          ),
        );
      },
      leading: CircleAvatar(
        radius: 50,
        backgroundImage: NetworkImage(user.avatarUrl ?? ''),
      ),
      title: Text(user.login ?? ''),
      subtitle: Text(
        user.login ?? '',
        style: const TextStyle(color: Colors.black),
      ),
    );
  }
}
