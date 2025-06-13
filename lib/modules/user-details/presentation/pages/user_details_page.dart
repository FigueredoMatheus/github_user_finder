import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_user_finder/modules/search-user/domain/entities/user.dart';
import 'package:github_user_finder/modules/user-details/presentation/bloc/user_details_bloc.dart';
import 'package:github_user_finder/modules/user-details/presentation/widgets/followers_repos_widget.dart';
import 'package:github_user_finder/modules/user-details/presentation/widgets/header.dart';
import 'package:github_user_finder/modules/user-details/presentation/widgets/repos_bar_chart.dart';
import 'package:github_user_finder/modules/user-details/presentation/widgets/user_bio.dart';

class UserDetailsPage extends StatefulWidget {
  final User user;

  const UserDetailsPage({super.key, required this.user});

  @override
  State<UserDetailsPage> createState() => _UserDetailsPageState();
}

class _UserDetailsPageState extends State<UserDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.user.login),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              UserDetailsHeader(user: widget.user),
              UserDetailsFollowersAndRepos(user: widget.user),
              UserDetailsBio(user: widget.user),
              BlocBuilder<UserDetailsBloc, UserDetailsState>(
                builder: (context, state) {
                  if (state is UserDetailsLoading) {
                    return Center(child: CircularProgressIndicator());
                  }

                  if (state is ReposCommitsLoaded) {
                    return ReposBarChart(repos: state.gitRepos);
                  }

                  return Container();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
