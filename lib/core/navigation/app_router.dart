import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_user_finder/core/navigation/app_routes_names.dart';
import 'package:github_user_finder/modules/search-user/domain/entities/user.dart';
import 'package:github_user_finder/modules/user-details/data/data-sources/remote/github_repo_api_service.dart';
import 'package:github_user_finder/modules/user-details/data/repositories/github_repo_impl.dart';
import 'package:github_user_finder/modules/user-details/domain/user-cases/get_last_five_user_repos.dart';
import 'package:github_user_finder/modules/user-details/presentation/bloc/user_details_bloc.dart';
import 'package:github_user_finder/modules/user-details/presentation/pages/user_details_page.dart';
import '../../modules/home/pages/home_page.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutesNames.HOME:
        return MaterialPageRoute(builder: (_) => const HomePage());

      case AppRoutesNames.USER_DETAILS:
        final user = settings.arguments as User;

        return MaterialPageRoute(
          builder: (_) => BlocProvider(
              create: (_) => UserDetailsBloc(
                    GetLastFiveUserRepos(
                      GithubRepoImpl(GithubRepoApiService(Dio())),
                    ),
                  )..add(LoadUserCommitsEvent(user)),
              child: UserDetailsPage(user: user)),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('Rota não encontrada')),
          ),
        );
    }
  }
}
