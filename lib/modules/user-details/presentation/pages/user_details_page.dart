import 'package:flutter/material.dart';
import 'package:github_user_finder/modules/search-user/domain/entities/user.dart';
import 'package:github_user_finder/modules/user-details/presentation/widgets/followers_repos_widget.dart';
import 'package:github_user_finder/modules/user-details/presentation/widgets/header.dart';

class UserDetailsPage extends StatelessWidget {
  final User user;

  const UserDetailsPage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(user.login),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            UserDetailsHeader(user: user),
            UserDetailsFollowersAndRepos(user: user),
          ],
        ),
      ),
    );
  }
}
