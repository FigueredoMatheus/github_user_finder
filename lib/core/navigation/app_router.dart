import 'package:flutter/material.dart';
import 'package:github_user_finder/core/navigation/app_routes_names.dart';
import 'package:github_user_finder/modules/search-user/data/models/user_model.dart';
import 'package:github_user_finder/modules/user-details/presentation/pages/user_details_page.dart';
import '../../modules/home/pages/home_page.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutesNames.HOME:
        return MaterialPageRoute(builder: (_) => const HomePage());

      case AppRoutesNames.USER_DETAILS:
        //final user = settings.arguments as User;

        final userModel = UserModel.fromJson({
          "login": "octocat",
          "name": "The Octocat",
          "bio": "GitHub mascot",
          "location": "San Francisco",
          "followers": 100,
          "public_repos": 8,
          "avatar_url": "https://avatars.githubusercontent.com/u/583231?v=4",
        });

        final userEntity = userModel.toEntity();

        return MaterialPageRoute(
            builder: (_) => UserDetailsPage(user: userEntity));

      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('Rota não encontrada')),
          ),
        );
    }
  }
}
