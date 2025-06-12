import 'package:flutter/material.dart';

class SearchLoadingBody extends StatelessWidget {
  const SearchLoadingBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: CircularProgressIndicator());
  }
}
