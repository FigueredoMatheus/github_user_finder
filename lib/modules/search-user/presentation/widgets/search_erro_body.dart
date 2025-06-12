import 'package:flutter/material.dart';

class SearchErroBody extends StatelessWidget {
  final String message;

  const SearchErroBody({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text(message));
  }
}
