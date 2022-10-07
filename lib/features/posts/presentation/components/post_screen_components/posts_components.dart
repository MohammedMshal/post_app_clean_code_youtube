
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_app/features/posts/presentation/posts_screen/post_detail_page.dart';

import '../../../domain/entities/posts.dart';
import '../../controller/posts/posts_bloc.dart';

class PostsComponents extends StatelessWidget {
  const PostsComponents({Key? key,required this.posts}) : super(key: key);
final List<Posts> posts ;
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async{
        return BlocProvider.of<PostsBloc>(context).add(RefreshPostsEvent());
      },
      child: ListView.separated(
        itemBuilder: (cnx, i) {
          return ListTile(
            leading: Text(posts[i].id.toString()),
            title: Text(posts[i].title,style: Theme.of(context).textTheme.titleLarge),
            subtitle: Text(posts[i].body,style: Theme.of(context).textTheme.bodyLarge),
            contentPadding: const EdgeInsets .symmetric(horizontal: 10),
            onTap: (){
              Navigator.push(context,MaterialPageRoute(builder: (_)=> PostDetailsScreen(posts: posts[i],)));
            },
          );
        },
        separatorBuilder: (cnx, i) => const Divider(),
        itemCount: posts.length,
      ),
    );
  }
}
