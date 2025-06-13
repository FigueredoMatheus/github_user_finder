import 'package:flutter/material.dart';
import 'package:github_user_finder/core/widgets/custom_loaded_user_card.dart';
import 'package:github_user_finder/modules/search-user/domain/entities/user.dart';

class CustomPaginatedUsersList extends StatelessWidget {
  final ScrollController scrollController;
  final List<User> users;
  final bool hasReachedEnd;

  const CustomPaginatedUsersList({
    super.key,
    required this.scrollController,
    required this.users,
    required this.hasReachedEnd,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      controller: scrollController,
      padding: const EdgeInsets.all(12),
      itemCount: hasReachedEnd ? users.length : users.length + 1,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        if (index >= users.length) {
          return const Center(child: CircularProgressIndicator());
        }

        final user = users[index];

        return CustomLoadedUserCard(user: user);
      },
    );
  }
}
