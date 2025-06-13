import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_user_finder/modules/search-user/data/data-sources/local/cache_user_service.dart';
import 'package:github_user_finder/modules/search-user/data/data-sources/remote/github_api_service.dart';
import 'package:github_user_finder/modules/search-user/data/repositories/user_repository_impl.dart';
import 'package:github_user_finder/modules/search-user/domain/user-cases/get_user_by_name.dart';
import 'package:github_user_finder/modules/search-user/presentation/bloc/search_user_bloc.dart';
import 'package:github_user_finder/modules/search-user/presentation/pages/search_user_page.dart';

class SearchTab extends StatelessWidget {
  const SearchTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SearchUserBloc(
        getUserByUsername: GetUserByUsername(
          UserRepositoryImpl(
            GithubApiService(Dio()),
            CacheUserService(),
          ),
        ),
        api: GithubApiService(Dio()),
        cacheUserService: CacheUserService(),
      ),
      child: const SearchUserPage(),
    );
  }
}
