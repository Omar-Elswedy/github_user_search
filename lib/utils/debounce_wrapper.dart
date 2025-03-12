import 'package:flutter/material.dart';
import 'package:flutter_debouncer/flutter_debouncer.dart';
import 'package:github_user_search/views/widgets/custom_search_field.dart';

class DebounceWrapper extends StatefulWidget {
  const DebounceWrapper({Key? key}) : super(key: key);

  @override
  DebounceWrapperState createState() => DebounceWrapperState();
}

class DebounceWrapperState extends State<DebounceWrapper> {
  final Debouncer debouncer = Debouncer();

  @override
  void dispose() {
    debouncer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomSearchField(debouncer: debouncer);
  }
}
