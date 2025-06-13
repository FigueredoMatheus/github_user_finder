part of 'user_details_bloc.dart';

sealed class UserDetailsEvent extends Equatable {
  const UserDetailsEvent();

  @override
  List<Object> get props => [];
}

final class LoadUserCommitsEvent extends UserDetailsEvent {
  final User user;

  const LoadUserCommitsEvent(this.user);

  @override
  List<Object> get props => [user];
}
