import 'package:flutter/material.dart';
import 'package:github_user_search/providers/user_provider.dart';
import 'package:github_user_search/utils/debounce_wrapper.dart';
import 'package:github_user_search/views/widgets/recent_query.dart';
import 'package:github_user_search/views/widgets/user_unit.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Github User Search'),
      ),
      body: CustomScrollView(
        slivers: [
          const DebounceWrapper(),
          Consumer<UserProvider>(
            builder: (context, userProvider, child) {
              if (userProvider.isLoading) {
                return const SliverFillRemaining(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else if (userProvider.errorMessage.isNotEmpty) {
                return SliverFillRemaining(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text(userProvider.errorMessage),
                    ),
                  ),
                );
              } else if (userProvider.keys.isNotEmpty &&
                  userProvider.users.isEmpty) {
                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final sharedkey = userProvider.keys[index];
                      return RecentQuery(
                        sharedkey: sharedkey,
                      );
                    },
                    childCount: userProvider.keys.length,
                  ),
                );
              } else if (userProvider.users.isEmpty) {
                return const SliverFillRemaining(
                  child: Center(
                    child: Text('No data to display'),
                  ),
                );
              }
              return SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final user = userProvider.users[index];
                    return UserUnit(user: user);
                  },
                  childCount: userProvider.users.length,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
