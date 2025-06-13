part of 'search_user_bloc.dart';

sealed class SearchUserState extends Equatable {
  const SearchUserState();

  @override
  List<Object> get props => [];
}

final class SearchUserInitial extends SearchUserState {
  final SearchByType searchByType;

  const SearchUserInitial({this.searchByType = SearchByType.username});

  @override
  List<Object> get props => [searchByType];
}

final class SearchUserFound extends SearchUserState {
  final User user;

  const SearchUserFound(this.user);

  @override
  List<Object> get props => [user];
}

class SearchRecentUsersLoaded extends SearchUserState {
  final List<User> users;
  const SearchRecentUsersLoaded(this.users);

  @override
  List<Object> get props => [users];
}

final class SearchError extends SearchUserState {
  final String message;

  const SearchError(this.message);

  @override
  List<Object> get props => [message];
}

class SearchLoading extends SearchUserState {}
