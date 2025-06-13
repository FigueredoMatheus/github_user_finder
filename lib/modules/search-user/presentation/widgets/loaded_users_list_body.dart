import 'package:flutter/material.dart';
import 'package:github_user_finder/modules/search-user/domain/entities/user.dart';
import 'package:github_user_finder/modules/search-user/presentation/widgets/custom_loaded_user_card.dart';

class LoadedUsersListBody extends StatelessWidget {
  final List<User> users;
  final String infoText;
  const LoadedUsersListBody(
      {super.key, required this.users, required this.infoText});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: users.length + 1,
      padding: const EdgeInsets.symmetric(vertical: 8),
      shrinkWrap: true,
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final isFirstItem = index == 0;

        if (isFirstItem) {
          return Text(
            infoText,
            style: TextStyle(fontSize: 12),
          );
        } else {
          return CustomLoadedUserCard(
            user: users[index - 1],
          );
        }
      },
    );
  }
}
