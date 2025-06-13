part of 'search_user_bloc.dart';

sealed class SearchUserEvent extends Equatable {
  const SearchUserEvent();

  @override
  List<Object> get props => [];
}

final class SearchByChanged extends SearchUserEvent {
  final SearchByType searchByType;

  const SearchByChanged(this.searchByType);

  @override
  List<Object> get props => [searchByType];
}

final class SearchSubmitted extends SearchUserEvent {
  final String query;

  const SearchSubmitted(this.query);

  @override
  List<Object> get props => [query];
}

final class SearchOnChanged extends SearchUserEvent {
  final String query;

  const SearchOnChanged(this.query);

  @override
  List<Object> get props => [query];
}

class SearchRecentRequested extends SearchUserEvent {}
