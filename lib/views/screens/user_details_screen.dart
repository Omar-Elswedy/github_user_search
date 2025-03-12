import 'package:flutter/material.dart';
import 'package:github_user_search/models/user_model.dart';
import 'package:github_user_search/providers/user_provider.dart';
import 'package:provider/provider.dart';

class UserDetailsScreen extends StatelessWidget {
  final UserModel user;
  const UserDetailsScreen({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Profile'),
      ),
      body: Consumer<UserProvider>(builder: (context, userProvider, child) {
        if (userProvider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: Column(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(
                          userProvider.user?.avatarUrl ?? user.avatarUrl!),
                      radius: 50,
                    ),
                    const SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 16),
                        Text(userProvider.user?.login ?? user.login!,
                            style: const TextStyle(fontSize: 24)),
                        const SizedBox(height: 16),
                        Text(userProvider.user?.htmlUrl ?? user.htmlUrl!,
                            style: const TextStyle(color: Colors.blue)),
                        const SizedBox(height: 16),
                        Text(userProvider.user?.name ?? user.name!,
                            style: const TextStyle(fontSize: 18)),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
