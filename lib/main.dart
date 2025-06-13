import 'package:flutter/material.dart';
import 'package:github_user_finder/core/navigation/app_router.dart';
import 'package:github_user_finder/core/navigation/app_routes_names.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GitHub Finder',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: AppRoutesNames.HOME,
      onGenerateRoute: AppRouter.generateRoute,
    );
  }
}
