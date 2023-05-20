import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:getxstateman/app/data/repositories/github_repository.dart';
import 'package:getxstateman/pages/details/details_controller.dart';

setupDetails() {
  Get.put(
    DetailsController(
      repository: GithubRepository(
        dio: Dio(),
      ),
    ),
  );
}
