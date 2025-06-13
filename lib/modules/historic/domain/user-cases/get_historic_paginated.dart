import 'package:github_user_finder/modules/search-user/data/repositories/user_repository_impl.dart';
import 'package:github_user_finder/modules/search-user/domain/entities/user.dart';

class GetHistoryPaginated {
  final UserRepositoryImpl repository;

  GetHistoryPaginated(this.repository);

  Future<List<User>> call({int limit = 10, int offset = 0}) {
    return repository.getUsersPaginated(limit: limit, offset: offset);
  }
}
