import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:github_user_finder/modules/search-user/domain/entities/user.dart';
import 'package:github_user_finder/modules/user-details/domain/entities/git_repo.dart';
import 'package:github_user_finder/modules/user-details/domain/user-cases/get_last_five_user_repos.dart';

part 'user_details_event.dart';
part 'user_details_state.dart';

class UserDetailsBloc extends Bloc<UserDetailsEvent, UserDetailsState> {
  final GetLastFiveUserRepos getLastFiveUserRepos;

  UserDetailsBloc(this.getLastFiveUserRepos) : super(UserDetailsInitial()) {
    on<LoadUserCommitsEvent>((event, emit) async {
      emit(UserDetailsLoading());

      try {
        // final user = await fetchUserByUsername(event.username);
        // await userDb.saveUser(user);

        final gitRepos = await getLastFiveUserRepos(event.user.login);

        //await repoDb.saveCommits(event.username, commits);

        emit(ReposCommitsLoaded(gitRepos));
      } catch (e) {
        emit(UserDetailsError('Erro ao carregar detalhes'));
      }
    });
  }
}
