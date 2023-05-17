import 'package:dio/dio.dart';
import 'package:getxstateman/app/data/models/github_user_model.dart';

class GithubRepository {
  final Dio dio;

  GithubRepository({required this.dio});

  Future<List<GithubUserModel>> getGithubUsers() async {
    final result = await dio.get('https://api.github.com/users');

    final List<GithubUserModel> users = [];

    if (result.statusCode == 200) {
      result.data
          .map((item) => users.add(GithubUserModel.fromMap(item)))
          .toList();
    }

    return users;
  }

  Future<GithubUserModel> getGithubUser({required String username}) async {
    final result = await dio.get('https://api.github.com/users/$username');

    late GithubUserModel githubUser;

    if (result.statusCode == 200) {
      githubUser = GithubUserModel.fromMap(result.data);
    }

    return githubUser;
  }
}
