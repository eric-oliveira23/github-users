import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';
import 'package:getxstateman/pages/details/details_binding.dart';
import 'details_controller.dart';

class DetailsPage extends StatefulWidget {
  final String username;

  const DetailsPage({super.key, required this.username});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage>
    with SingleTickerProviderStateMixin {
  late final DetailsController _controller;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    setupDetails();

    _controller = Get.find();
    _controller.getGithubUser(username: widget.username);

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeScaleTransition(
      animation: _animationController,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Details'),
        ),
        body: Obx(() {
          return _controller.isLoading.value
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : _controller.githubUser == null
                  ? const Center(
                      child: Text('User not found.'),
                    )
                  : _buildUserInfo();
        }),
      ),
    );
  }

  Widget _buildUserInfo() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          AnimatedPositioned(
            duration: const Duration(seconds: 2),
            curve: Curves.fastOutSlowIn,
            width: 50,
            height: 75,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                _controller.githubUser!.avatarUrl,
                height: 275,
                width: double.infinity,
              ),
            ),
          ),
          const SizedBox(height: 25),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Icon(
              Icons.emoji_people_rounded,
              color: Theme.of(context).primaryColor,
            ),
            title: const Text(
              'Name',
              style: TextStyle(
                color: Colors.black54,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              _controller.githubUser?.name ?? 'No information.',
              style: const TextStyle(
                color: Colors.black,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Icon(
              Icons.short_text_rounded,
              color: Theme.of(context).primaryColor,
            ),
            title: const Text(
              'Login',
              style: TextStyle(
                color: Colors.black54,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              _controller.githubUser!.login,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Icon(
              Icons.grain_outlined,
              color: Theme.of(context).primaryColor,
            ),
            title: const Text(
              'Public Repos',
              style: TextStyle(
                color: Colors.black54,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              _controller.githubUser!.publicRepos.toString(),
              style: const TextStyle(
                color: Colors.black,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Icon(
              Icons.people_alt,
              color: Theme.of(context).primaryColor,
            ),
            title: const Text(
              'Followers',
              style: TextStyle(
                color: Colors.black54,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              _controller.githubUser!.followers.toString(),
              style: const TextStyle(
                color: Colors.black,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Icon(
              Icons.maps_home_work_rounded,
              color: Theme.of(context).primaryColor,
            ),
            title: const Text(
              'Local',
              style: TextStyle(
                color: Colors.black54,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              _controller.githubUser!.location ?? 'No information.',
              style: const TextStyle(
                color: Colors.black,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ],
      ),
    );
  }
}
