import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_app/core/utils/app_constance.dart';
import 'package:posts_app/features/posts/presentation/components/post_screen_components/posts_components.dart';
import 'package:posts_app/features/posts/presentation/components/post_screen_components/show_error_components.dart';

import '../controller/posts/posts_bloc.dart';

class PostsScreen extends StatelessWidget {
  const PostsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostsBloc, PostsState>(
      builder: (context, state) {
        if (state is LoadingPostsState) {
          return AppConstance.loadingPage();
        } else if (state is LoadedPostsState) {
          return PostsComponents(posts: state.posts);
        } else if (state is ErrorPostsState) {
          return ShowErrorComponents(state: state);
        }
        return AppConstance.loadingPage(color: Colors.red);
      },
    );
  }

}
