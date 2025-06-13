import 'package:flutter/material.dart';
import 'package:github_user_finder/modules/search-user/domain/entities/user.dart';
import 'package:github_user_finder/core/widgets/custom_loaded_user_card.dart';

class LoadedUserBody extends StatelessWidget {
  final User user;

  const LoadedUserBody({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [CustomLoadedUserCard(user: user)],
    );
  }
}
