import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_user_finder/modules/search-user/presentation/bloc/search_user_bloc.dart';
import 'package:github_user_finder/modules/search-user/presentation/utils/enums/search_filter_type.dart';
import 'package:github_user_finder/modules/search-user/presentation/widgets/custom_text_field_widget.dart';

class SearchTextFieldWidget extends StatefulWidget {
  final SearchByType searchByType;

  const SearchTextFieldWidget({
    super.key,
    required this.searchByType,
  });

  @override
  State<SearchTextFieldWidget> createState() => _SearchTextFieldWidgetState();
}

class _SearchTextFieldWidgetState extends State<SearchTextFieldWidget> {
  final searchField1Controller = TextEditingController();
  final searchField2Controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final isLocationSearch = widget.searchByType == SearchByType.location;

    final hasSearchByType = widget.searchByType != SearchByType.none;

    final isSearchByUsername = widget.searchByType == SearchByType.username;

    return Padding(
      padding: const EdgeInsets.only(top: 15.0),
      child: Column(
        children: [
          Visibility(
            visible: hasSearchByType,
            child: CustomTextField(
              controller: searchField1Controller,
              hintText: hintText,
              keyboardType: keyboardType,
              onSubmitted: onSubmitted,
              onChanged: isSearchByUsername ? onChanged : null,
              onTap: isSearchByUsername ? onTap : null,
            ),
          ),
          Visibility(
            visible: isLocationSearch,
            child: Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: CustomTextField(
                controller: searchField2Controller,
                hintText: 'Cidade',
              ),
            ),
          ),
        ],
      ),
    );
  }

  String get hintText {
    switch (widget.searchByType) {
      case SearchByType.username:
        return 'Username';
      case SearchByType.location:
        return 'Estado';
      case SearchByType.followers:
        return 'Nº mínimo de seguidores';
      case SearchByType.repos:
        return 'Nº mínimo de repositórios';
      case SearchByType.none:
        return '';
    }
  }

  TextInputType get keyboardType {
    switch (widget.searchByType) {
      case SearchByType.username:
        return TextInputType.text;
      case SearchByType.location:
        return TextInputType.text;
      case SearchByType.followers:
        return TextInputType.number;
      case SearchByType.repos:
        return TextInputType.number;
      case SearchByType.none:
        return TextInputType.none;
    }
  }

  void onSubmitted(String? value) {
    if (value != null) {
      context.read<SearchUserBloc>().add(SearchSubmitted(value));
    }
  }

  void onChanged(String? value) {
    if (value != null) {
      context.read<SearchUserBloc>().add(SearchOnChanged(value));
    }
  }

  void onTap() {
    context.read<SearchUserBloc>().add(SearchRecentRequested());
  }
}
