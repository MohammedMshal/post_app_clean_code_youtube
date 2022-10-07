import 'package:flutter/material.dart';
import 'package:posts_app/features/posts/presentation/controller/posts/posts_bloc.dart';

class ShowErrorComponents extends StatelessWidget {
  const ShowErrorComponents({Key? key,required this.state}) : super(key: key);
final ErrorPostsState state;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 3,
      child: Center(
        child: SingleChildScrollView(
          child: Text(state.message,style: Theme.of(context).textTheme.bodyMedium,textAlign: TextAlign.center,),
        ),
      ),
    );

  }
}
