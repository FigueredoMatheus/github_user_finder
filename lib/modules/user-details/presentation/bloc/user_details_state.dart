part of 'user_details_bloc.dart';

sealed class UserDetailsState extends Equatable {
  const UserDetailsState();

  @override
  List<Object> get props => [];
}

final class UserDetailsInitial extends UserDetailsState {}

class UserDetailsLoading extends UserDetailsState {}

class ReposCommitsLoaded extends UserDetailsState {
  final List<GitRepo> gitRepos;

  const ReposCommitsLoaded(this.gitRepos);
}

class UserDetailsError extends UserDetailsState {
  final String message;

  const UserDetailsError(this.message);
}
