import 'package:flutter/material.dart';
import 'package:github_user_finder/core/navigation/app_routes_names.dart';
import 'package:github_user_finder/modules/search-user/domain/entities/user.dart';
import 'package:github_user_finder/modules/search-user/presentation/pages/user_details_page.dart';
import '../../modules/home/pages/home_page.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutesNames.HOME:
        return MaterialPageRoute(builder: (_) => const HomePage());

      case AppRoutesNames.USER_DETAILS:
        final user = settings.arguments as User;

        return MaterialPageRoute(builder: (_) => UserDetailsPage(user: user));

      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('Rota não encontrada')),
          ),
        );
    }
  }
}
