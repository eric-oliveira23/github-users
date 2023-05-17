import 'package:get/get.dart';
import 'package:getxstateman/app/data/models/github_user_model.dart';
import 'package:getxstateman/app/data/repositories/github_repository.dart';

class HomeController extends GetxController {
  final GithubRepository repository;

  final List<GithubUserModel> _users = <GithubUserModel>[].obs;
  List<GithubUserModel> get users => _users;

  final RxBool _isLoading = false.obs;
  RxBool get isLoading => _isLoading;

  HomeController({required this.repository});

  getGithubUsers() async {
    _isLoading.value = true;

    final response = await repository.getGithubUsers();

    _users.addAll(response);

    _isLoading.value = false;
  }
}
