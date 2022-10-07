import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_app/features/posts/presentation/components/add_update_post_components/textformfield_components.dart';
import 'package:posts_app/features/posts/presentation/controller/add_delete_update_posts/add_delete_update_posts_bloc.dart';

import '../../../domain/entities/posts.dart';

class FormComponents extends StatefulWidget {
  const FormComponents({
    Key? key,
    required this.isUpdatePost,
    required this.posts,
  }) : super(key: key);
  final bool isUpdatePost;
  final Posts? posts;

  @override
  State<FormComponents> createState() => _FormComponentsState();
}

class _FormComponentsState extends State<FormComponents> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _bodyController = TextEditingController();

  @override
  void initState() {
    if (widget.isUpdatePost) {
      _titleController.text = widget.posts!.title;
      _bodyController.text = widget.posts!.body;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormFieldComponents(
              controller: _titleController,
              hintText: 'Title',
              emptyText: 'empty title',
              maxLine: false,
              minLine: false,
            ),
            TextFormFieldComponents(
              controller: _bodyController,
              hintText: 'Body',
              emptyText: 'empty body',
              maxLine: true,
              minLine: true,
            ),
            ElevatedButton.icon(
                onPressed: funcForm,
                icon: Icon(widget.isUpdatePost
                    ? Icons.edit_outlined
                    : Icons.add_outlined),
                label: Text(widget.isUpdatePost ? 'Update Post' : 'Add Post'))
          ],
        ));
  }

  void funcForm() {
    if (_formKey.currentState!.validate()) {
      final post = Posts(
        id: widget.isUpdatePost ? widget.posts!.id : null,
        body: _bodyController.text,
        title: _titleController.text,
      );
      if (widget.isUpdatePost) {
        BlocProvider.of<AddDeleteUpdatePostsBloc>(context)
            .add(UpdatePostEvent(posts: post));
      } else {
        BlocProvider.of<AddDeleteUpdatePostsBloc>(context)
            .add(AddPostEvent(posts: post));
      }
    }
  }
}
