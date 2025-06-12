import 'package:flutter/material.dart';
import 'package:github_user_finder/modules/search-user/presentation/utils/enums/search_filter_type.dart';
import 'package:github_user_finder/modules/search-user/presentation/utils/extensions/on_search_filter_type.dart';
import 'package:github_user_finder/modules/search-user/presentation/widgets/search_user_by_modal_body.dart';

class SearchByWidget extends StatelessWidget {
  final SearchByType? searchByType;

  const SearchByWidget({super.key, required this.searchByType});

  @override
  Widget build(BuildContext context) {
    final hasSearchByType =
        searchByType != null && searchByType != SearchByType.none;

    return InkWell(
      onTap: () {
        showModalBottomSheet<void>(
          context: context,
          builder: (BuildContext context) {
            return const SearchUserByModalBody();
          },
        );
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.grey.shade300, width: 1),
          ),
        ),
        child: ListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(
            'Buscar por',
            style: TextStyle(
              fontWeight: hasSearchByType ? FontWeight.w400 : FontWeight.bold,
              fontSize: hasSearchByType ? 14 : 16,
            ),
          ),
          subtitle: hasSearchByType
              ? Text(
                  searchByType!.searchByLabel,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                )
              : null,
          trailing: Icon(Icons.arrow_forward_rounded),
        ),
      ),
    );
  }
}
