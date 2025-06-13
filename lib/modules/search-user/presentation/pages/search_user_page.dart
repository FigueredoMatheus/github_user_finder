import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_user_finder/modules/search-user/presentation/bloc/search_user_bloc.dart';
import 'package:github_user_finder/modules/search-user/presentation/widgets/loaded_user_body.dart';
import 'package:github_user_finder/modules/search-user/presentation/widgets/loaded_users_list_body.dart';
import 'package:github_user_finder/modules/search-user/presentation/widgets/search_by_widget.dart';
import 'package:github_user_finder/modules/search-user/presentation/widgets/search_erro_body.dart';
import 'package:github_user_finder/modules/search-user/presentation/widgets/search_loading_body.dart';
import 'package:github_user_finder/modules/search-user/presentation/widgets/search_text_field_widget.dart';

class SearchUserPage extends StatelessWidget {
  const SearchUserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: false,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text('Buscador de Usuários do GitHub'),
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 16,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            BlocBuilder<SearchUserBloc, SearchUserState>(
                builder: (context, state) {
              final searchByType = state is SearchUserInitial
                  ? state.searchByType
                  : context.read<SearchUserBloc>().currentSearchByType;

              return Column(
                children: [
                  SearchByWidget(searchByType: searchByType),
                  SearchTextFieldWidget(searchByType: searchByType),
                ],
              );
            }),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 15),
                child: BlocBuilder<SearchUserBloc, SearchUserState>(
                    builder: (context, state) {
                  if (state is SearchUserFound) {
                    return LoadedUserBody(user: state.user);
                  }

                  if (state is SearchLoading) {
                    return SearchLoadingBody();
                  }

                  if (state is SearchError) {
                    return SearchErroBody(message: state.message);
                  }

                  if (state is SearchRecentUsersLoaded) {
                    return LoadedUsersListBody(users: state.users);
                  }

                  return Container();
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
