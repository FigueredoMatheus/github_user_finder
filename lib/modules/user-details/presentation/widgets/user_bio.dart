import 'package:flutter/material.dart';
import 'package:github_user_finder/modules/search-user/domain/entities/user.dart';

class UserDetailsBio extends StatelessWidget {
  final User user;

  const UserDetailsBio({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: user.bio != null,
      replacement: Container(),
      child: Padding(
        padding: const EdgeInsets.only(top: 20.0, bottom: 20),
        child: Row(
          children: [
            Expanded(
              child: Text(
                user.bio!,
                textAlign: TextAlign.left,
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
