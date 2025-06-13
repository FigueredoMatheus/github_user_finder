import 'package:flutter/material.dart';
import 'package:github_user_finder/modules/search-user/domain/entities/user.dart';
import 'package:github_user_finder/modules/user-details/utils/extensions/number_format.dart';

class UserDetailsFollowersAndRepos extends StatelessWidget {
  final User user;

  const UserDetailsFollowersAndRepos({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildItem('Seguidores', user.followers),
          _buildItem('Repos Públicos', user.publicRepos),
        ],
      ),
    );
  }
}

Widget _buildItem(String label, int amount) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        label,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      Text(amount.formatCompact()),
    ],
  );
}
