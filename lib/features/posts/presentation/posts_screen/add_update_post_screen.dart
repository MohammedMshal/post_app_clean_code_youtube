import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_app/config/routes/app_routes.dart';
import 'package:posts_app/core/utils/app_constance.dart';
import 'package:posts_app/core/utils/app_enums.dart';
import 'package:posts_app/core/utils/app_strings.dart';
import 'package:posts_app/features/posts/presentation/controller/add_delete_update_posts/add_delete_update_posts_bloc.dart';

import '../../domain/entities/posts.dart';
import '../components/add_update_post_components/from_components.dart';

class AddUpdatePostScreen extends StatelessWidget {
  const AddUpdatePostScreen({
    Key? key,
    this.post,
    required this.isUpdate,
  }) : super(key: key);
  final Posts? post;
  final bool isUpdate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text( isUpdate ? AppStrings.titleEditeScreen: AppStrings.titleAddScreen)
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: BlocConsumer<AddDeleteUpdatePostsBloc, AddDeleteUpdatePostsStates>(
            listener: (context, state) {
              if(state is MessageSuccessAddDeleteUpdatePost){
                AppConstance.showToast(msg: state.message, status: ToastStatus.success);
                AppConstance.navigatorRemovedTo(context: context, route: Routes.initialRoute);
              }else if(state is ErrorAddDeleteUpdatePostState){
                AppConstance.showToast(msg: state.message, status: ToastStatus.error);
              }
            },
            builder: (context, state) {
              if(state is LoadingAddDeleteUpdatePostState){
                return AppConstance.loadingPage();
              }
                return FormComponents(
                  isUpdatePost: isUpdate,
                  posts: isUpdate ? post : null,
                );
            },
          ),
        ),
      ),
    );
  }
}
