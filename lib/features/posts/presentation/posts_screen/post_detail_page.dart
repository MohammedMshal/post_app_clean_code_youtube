import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_app/config/routes/app_routes.dart';
import 'package:posts_app/core/utils/app_constance.dart';
import 'package:posts_app/core/utils/app_enums.dart';
import 'package:posts_app/core/utils/app_strings.dart';
import 'package:posts_app/features/posts/presentation/controller/add_delete_update_posts/add_delete_update_posts_bloc.dart';
import 'package:posts_app/features/posts/presentation/posts_screen/add_update_post_screen.dart';
import '../../domain/entities/posts.dart';

class PostDetailsScreen extends StatelessWidget {
  final Posts posts;

  const PostDetailsScreen({Key? key, required this.posts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.titleDetailsScreen)),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Text(posts.title, style: Theme.of(context).textTheme.titleLarge),
              const Divider(height: 50.0),
              Text(posts.body, style: Theme.of(context).textTheme.bodyMedium),
              const Divider(height: 50.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  //edit btn
                  ElevatedButton.icon(
                      onPressed: () {
                        AppConstance.navigatorToAno(
                          context: context,
                          screen:
                              AddUpdatePostScreen(isUpdate: true, post: posts),
                        );
                      },
                      icon: const Icon(Icons.edit_outlined),
                      label: const Text(AppStrings.editButton)),
                  //delete btn
                  ElevatedButton.icon(
                    onPressed: () => showDialogDelete(context),
                    icon: const Icon(Icons.delete_outline),
                    label: const Text(AppStrings.deleteButton),
                    style: const ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(Colors.redAccent)),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void showDialogDelete(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return BlocConsumer<AddDeleteUpdatePostsBloc,
            AddDeleteUpdatePostsStates>(
          listener: (context, state) {
            if (state is MessageSuccessAddDeleteUpdatePost) {
              AppConstance.showToast(
                  msg: state.message, status: ToastStatus.success);
              AppConstance.navigatorRemovedTo(
                  context: context, route: Routes.initialRoute);
            } else if (state is ErrorAddDeleteUpdatePostState) {
              AppConstance.navigatorPop(context: context);
              AppConstance.showToast(
                  msg: state.message, status: ToastStatus.error);
            }
          },
          builder: (context, state) {
            if (state is LoadingAddDeleteUpdatePostState) {
              return AlertDialog(
                title: AppConstance.loadingPage(),
              );
            }
            return AlertDialog(
              title: const Text('Are you Sure'),
              actions: [
                TextButton(
                    onPressed: () =>
                        AppConstance.navigatorPop(context: context),
                    child: const Text('NO')),
                TextButton(
                    onPressed: () {
                      BlocProvider.of<AddDeleteUpdatePostsBloc>(context)
                          .add(DeletePostEvent(postId: posts.id!));
                    },
                    child: const Text('Yes')),
              ],
            );
          },
        );
      },
    );
  }
}
