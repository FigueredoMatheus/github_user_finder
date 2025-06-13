import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:github_user_finder/modules/historic/domain/user-cases/get_historic_paginated.dart';

import 'package:github_user_finder/modules/search-user/domain/entities/user.dart';

part 'historic_event.dart';
part 'historic_state.dart';

class HistoricBloc extends Bloc<HistoricEvent, HistoricState> {
  final GetHistoryPaginated getHistoryPaginated;

  final int _limit = 10;

  int _offset = 0;
  bool _isFetching = false;

  HistoricBloc({required this.getHistoryPaginated}) : super(HistoricInitial()) {
    on<LoadHistoryInitial>((event, emit) async {
      emit(HistoricLoading());

      _offset = 0;

      final users = await getHistoryPaginated(limit: _limit, offset: _offset);

      emit(HistoricLoaded(users, hasReachedEnd: users.length < _limit));

      _offset += users.length;
    });

    on<LoadMoreHistoryRequested>((event, emit) async {
      if (_isFetching || state is! HistoricLoaded) return;
      _isFetching = true;

      final currentUsers = (state as HistoricLoaded).users;
      final newUsers =
          await getHistoryPaginated(limit: _limit, offset: _offset);

      emit(HistoricLoaded(
        [...currentUsers, ...newUsers],
        hasReachedEnd: newUsers.length < _limit,
      ));

      _offset += newUsers.length;
      _isFetching = false;
    });
  }
}
