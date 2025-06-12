class User {
  final String login;
  final String name;
  final String? bio;
  final String? location;
  final String avatarUrl;
  final int followers;
  final int publicRepos;

  User({
    required this.avatarUrl,
    required this.login,
    required this.name,
    required this.followers,
    required this.publicRepos,
    this.bio,
    this.location,
  });
}
