import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_user_finder/modules/search-user/presentation/bloc/search_user_bloc.dart';
import 'package:github_user_finder/modules/search-user/presentation/utils/enums/search_filter_type.dart';
import 'package:github_user_finder/modules/search-user/presentation/utils/extensions/on_search_filter_type.dart';

class SearchUserByModalBody extends StatelessWidget {
  const SearchUserByModalBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 10, left: 15),
            child: Text('Buscar por',
                style: Theme.of(context).textTheme.bodyLarge),
          ),
        ),
        _buildItem(context, SearchByType.username),
        _buildItem(context, SearchByType.location),
        _buildItem(context, SearchByType.followers),
        _buildItem(context, SearchByType.repos),
      ],
    );
  }
}

Widget _buildItem(BuildContext context, SearchByType searchByType) {
  return ListTile(
    title: Text(searchByType.searchByLabel),
    onTap: () {
      context.read<SearchUserBloc>().add(SearchByChanged(searchByType));
      Navigator.pop(context);
    },
  );
}
