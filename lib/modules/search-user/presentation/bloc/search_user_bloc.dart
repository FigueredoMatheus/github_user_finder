import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:github_user_finder/core/exceptions/app_exceptions.dart';
import 'package:github_user_finder/modules/search-user/data/data-sources/local/cache_user_service.dart';
import 'package:github_user_finder/modules/search-user/data/data-sources/remote/github_api_service.dart';
import 'package:github_user_finder/modules/search-user/domain/entities/user.dart';
import 'package:github_user_finder/modules/search-user/domain/user-cases/get_user_by_name.dart';
import 'package:github_user_finder/modules/search-user/presentation/utils/enums/search_filter_type.dart';

part 'search_user_event.dart';
part 'search_user_state.dart';

class SearchUserBloc extends Bloc<SearchUserEvent, SearchUserState> {
  final GetUserByUsername getUserByUsername;
  final GithubApiService api;
  final CacheUserService cacheUserService;

  SearchByType currentSearchByType = SearchByType.username;

  SearchUserBloc({
    required this.getUserByUsername,
    required this.api,
    required this.cacheUserService,
  }) : super(SearchUserInitial()) {
    on<SearchByChanged>((event, emit) {
      currentSearchByType = event.searchByType;

      emit(SearchUserInitial(searchByType: currentSearchByType));
    });

    on<SearchSubmitted>((event, emit) async {
      emit(SearchLoading());

      final query = event.query.trim();

      try {
        final user = await getUserByUsername(query);

        emit(SearchUserFound(user));
      } on AppException catch (e) {
        emit(SearchError(e.message));
      }
    });

    on<SearchRecentRequested>((event, emit) async {
      final recent = await cacheUserService.getLastUsers(limit: 5);

      emit(SearchRecentUsersLoaded(recent.map((e) => e.toEntity()).toList()));
    });

    on<SearchOnChanged>((event, emit) async {
      final query = event.query.trim();

      if (query.length >= 2) {
        final suggestions =
            await cacheUserService.searchUsersByPartialUsername(query);

        emit(SearchSuggestionsLoaded(
            suggestions.map((e) => e.toEntity()).toList()));
      } else {
        add(SearchRecentRequested());
      }
    });
  }
}
