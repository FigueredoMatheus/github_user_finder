import 'package:github_user_finder/modules/search-user/presentation/utils/enums/search_filter_type.dart';

extension SearchFilterLabel on SearchByType {
  String get searchByLabel {
    switch (this) {
      case SearchByType.username:
        return 'Username';
      case SearchByType.location:
        return 'Localização';
      case SearchByType.followers:
        return 'Seguidores';
      case SearchByType.repos:
        return 'Repositórios';
      case SearchByType.none:
        return '';
    }
  }
}
