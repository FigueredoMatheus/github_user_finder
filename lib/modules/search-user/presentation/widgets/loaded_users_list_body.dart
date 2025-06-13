import 'package:flutter/material.dart';
import 'package:github_user_finder/modules/search-user/domain/entities/user.dart';
import 'package:github_user_finder/core/widgets/custom_loaded_user_card.dart';

class LoadedUsersListBody extends StatelessWidget {
  final List<User> users;
  final String? infoText;

  const LoadedUsersListBody({
    super.key,
    required this.users,
    this.infoText,
  });

  @override
  Widget build(BuildContext context) {
    final hasInfoText = infoText != null;

    return ListView.separated(
      itemCount: hasInfoText ? users.length + 1 : users.length,
      padding: const EdgeInsets.symmetric(vertical: 8),
      shrinkWrap: true,
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final isFirstItem = index == 0;

        if (isFirstItem && hasInfoText) {
          return Text(
            infoText!,
            style: TextStyle(fontSize: 12),
          );
        } else {
          final userIndex = hasInfoText ? index - 1 : index;

          return CustomLoadedUserCard(user: users[userIndex]);
        }
      },
    );
  }
}
