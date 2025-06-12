import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:github_user_finder/modules/search-user/domain/entities/user.dart';
import 'package:github_user_finder/modules/search-user/presentation/utils/enums/search_filter_type.dart';

part 'search_user_event.dart';
part 'search_user_state.dart';

class SearchUserBloc extends Bloc<SearchUserEvent, SearchUserState> {
  SearchByType currentSearchByType = SearchByType.none;

  SearchUserBloc() : super(SearchUserInitial()) {
    on<SearchByChanged>((event, emit) {
      currentSearchByType = event.searchByType;

      emit(SearchUserInitial(searchByType: currentSearchByType));
    });
  }
}
