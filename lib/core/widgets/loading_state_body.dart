import 'package:flutter/material.dart';

class LoadingStateBody extends StatelessWidget {
  const LoadingStateBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: CircularProgressIndicator());
  }
}
