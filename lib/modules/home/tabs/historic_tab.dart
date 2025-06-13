import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_user_finder/modules/historic/domain/user-cases/get_historic_paginated.dart';
import 'package:github_user_finder/modules/historic/presentation/bloc/historic_bloc.dart';
import 'package:github_user_finder/modules/historic/presentation/pages/historic_page.dart';
import 'package:github_user_finder/modules/search-user/data/data-sources/local/cache_user_service.dart';
import 'package:github_user_finder/modules/search-user/data/data-sources/remote/github_api_service.dart';
import 'package:github_user_finder/modules/search-user/data/repositories/user_repository_impl.dart';

class HistoricTab extends StatelessWidget {
  const HistoricTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HistoricBloc(
        getHistoryPaginated: GetHistoryPaginated(
          UserRepositoryImpl(
            GithubApiService(Dio()),
            CacheUserService(),
          ),
        ),
      )..add(LoadHistoryInitial()),
      child: HistoricPage(),
    );
  }
}
