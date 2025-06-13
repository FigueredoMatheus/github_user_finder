import 'package:flutter/material.dart';
import 'package:github_user_finder/modules/search-user/domain/entities/user.dart';

class UserDetailsHeader extends StatelessWidget {
  final User user;

  const UserDetailsHeader({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          backgroundImage: NetworkImage(user.avatarUrl),
          maxRadius: 45,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                user.name,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                ),
              ),
              Text(
                user.login,
                style: const TextStyle(fontSize: 16, color: Colors.black54),
              ),
              Visibility(
                visible: user.location != null,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.location_on,
                      color: Colors.black54,
                      size: 16,
                    ),
                    Text(
                      user.location!,
                      style:
                          const TextStyle(fontSize: 14, color: Colors.black54),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
