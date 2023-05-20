import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getxstateman/pages/details/details_page.dart';
import 'package:getxstateman/pages/home/home_binding.dart';
import 'package:getxstateman/pages/home/home_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final HomeController _controller;

  @override
  void initState() {
    super.initState();

    setupHome();

    _controller = Get.find();
    _controller.getGithubUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Github Users'),
      ),
      body: Obx(() {
        return _controller.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : _controller.users.isEmpty
                ? const Center(child: Text('Users not found.'))
                : ListView.separated(
                    separatorBuilder: (context, index) => const Divider(),
                    physics: const BouncingScrollPhysics(),
                    itemCount: _controller.users.length,
                    itemBuilder: (context, index) {
                      final item = _controller.users[index];
                      return ListTile(
                        title: Text(item.login),
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(item.avatarUrl),
                        ),
                        onTap: () {
                          Get.to(() => DetailsPage(username: item.login));
                        },
                      );
                    },
                  );
      }),
    );
  }
}
