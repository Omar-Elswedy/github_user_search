import 'package:flutter/material.dart';
import 'package:github_user_search/providers/user_provider.dart';
import 'package:provider/provider.dart';

class RecentQuery extends StatelessWidget {
  final String sharedkey;
  const RecentQuery({
    super.key,
    required this.sharedkey,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: ListTile(
        onTap: () {
          Provider.of<UserProvider>(context, listen: false)
              .searchUsers(sharedkey);
        },
        title: Text(sharedkey),
        trailing: IconButton(
          padding: EdgeInsets.zero,
          icon: const Icon(Icons.close, color: Colors.blue),
          onPressed: () {
            Provider.of<UserProvider>(context, listen: false)
                .deleteKeys(sharedkey);
          },
        ),
      ),
    );
  }
}
