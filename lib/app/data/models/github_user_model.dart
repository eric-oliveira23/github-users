import 'dart:convert';

class GithubUserModel {
  final String login;
  final String avatarUrl;
  final String? location;
  final String? name;
  final int? followers;
  final int? publicRepos;

  GithubUserModel({
    required this.login,
    required this.avatarUrl,
    this.location,
    this.name,
    this.followers,
    this.publicRepos,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'login': login,
      'avatar_url': avatarUrl,
      'location': location,
      'name': name,
      'followers': followers,
      'public_repos': publicRepos,
    };
  }

  factory GithubUserModel.fromMap(Map<String, dynamic> map) {
    return GithubUserModel(
      login: map['login'],
      avatarUrl: map['avatar_url'],
      location: map['location'],
      name: map['name'],
      followers: map['followers'],
      publicRepos: map['public_repos'],
    );
  }

  String toJson() => json.encode(toMap());

  factory GithubUserModel.fromJson(String source) =>
      GithubUserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
