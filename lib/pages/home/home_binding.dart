import 'package:dio/dio.dart';
import 'package:get/instance_manager.dart';
import 'package:getxstateman/app/data/repositories/github_repository.dart';
import 'package:getxstateman/pages/home/home_controller.dart';

setupHome() {
  Get.put(
    HomeController(
      repository: GithubRepository(
        dio: Dio(),
      ),
    ),
  );
}
