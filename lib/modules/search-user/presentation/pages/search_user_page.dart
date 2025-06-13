import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_user_finder/core/navigation/app_routes_names.dart';
import 'package:github_user_finder/modules/search-user/presentation/bloc/search_user_bloc.dart';
import 'package:github_user_finder/modules/search-user/presentation/widgets/loaded_user_body.dart';
import 'package:github_user_finder/modules/search-user/presentation/widgets/loaded_users_list_body.dart';
import 'package:github_user_finder/modules/search-user/presentation/widgets/search_by_widget.dart';
import 'package:github_user_finder/modules/search-user/presentation/widgets/search_erro_body.dart';
import 'package:github_user_finder/core/widgets/loading_state_body.dart';
import 'package:github_user_finder/modules/search-user/presentation/widgets/search_text_field_widget.dart';

class SearchUserPage extends StatelessWidget {
  const SearchUserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
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
              child: BlocListener<SearchUserBloc, SearchUserState>(
                listener: (context, state) {
                  if (state is SearchUserFound) {
                    Navigator.pushNamed(
                      context,
                      AppRoutesNames.USER_DETAILS,
                      arguments: state.user,
                    );
                  }
                },
                child: BlocBuilder<SearchUserBloc, SearchUserState>(
                  builder: (context, state) {
                    if (state is SearchUserFound) {
                      return LoadedUserBody(user: state.user);
                    }

                    if (state is SearchLoading) {
                      return LoadingStateBody();
                    }

                    if (state is SearchError) {
                      return SearchErroBody(message: state.message);
                    }

                    if (state is SearchRecentUsersLoaded) {
                      return LoadedUsersListBody(
                        users: state.users,
                        infoText: '* Buscas recentes...',
                      );
                    }

                    if (state is SearchSuggestionsLoaded) {
                      return LoadedUsersListBody(
                        users: state.suggestions,
                        infoText: '* Sugestões...',
                      );
                    }

                    return Container();
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
