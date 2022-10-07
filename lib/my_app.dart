import 'package:flutter/material.dart';
import 'package:posts_app/features/posts/presentation/posts_screen/add_update_post_screen.dart';

import 'core/utils/app_strings.dart';
import 'features/posts/presentation/posts_screen/posts_screen.dart';

class HomeMyApp extends StatelessWidget {
  const HomeMyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.titleApp),
      ),
      body: const PostsScreen(),
      floatingActionButton: _floatingPage(
        context: context,
      ),
    );
  }
}

Widget _floatingPage({
  required BuildContext context,
}) {
  return FloatingActionButton(
    onPressed: () {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  const AddUpdatePostScreen(isUpdate: false)));
    },
    child: const Icon(Icons.add),
  );
}
