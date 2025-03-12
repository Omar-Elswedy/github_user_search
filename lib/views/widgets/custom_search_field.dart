import 'package:flutter/material.dart';
import 'package:flutter_debouncer/flutter_debouncer.dart';
import 'package:github_user_search/providers/user_provider.dart';
import 'package:provider/provider.dart';

class CustomSearchField extends StatelessWidget {
  final Debouncer debouncer;
  const CustomSearchField({super.key, required this.debouncer});

  void onSearchChanged(String query, VoidCallback onDebounce) {
    debouncer.debounce(
      duration: const Duration(seconds: 1),
      onDebounce: onDebounce,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: TextField(
          controller: Provider.of<UserProvider>(context, listen: false)
              .searchController,
          keyboardType: TextInputType.text,
          onTap: () {
            Provider.of<UserProvider>(context, listen: false).getKeys();
          },
          onChanged: (value) {
            onSearchChanged(value, () {
              Provider.of<UserProvider>(context, listen: false)
                  .searchUsers(value);
            });
          },
          decoration: const InputDecoration(
            hintText: 'Search user',
            prefixIcon: Icon(Icons.search),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
            ),
          ),
        ),
      ),
    );
  }
}
