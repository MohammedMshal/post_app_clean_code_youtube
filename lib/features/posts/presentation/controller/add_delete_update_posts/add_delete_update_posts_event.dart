part of 'add_delete_update_posts_bloc.dart';

abstract class AddDeleteUpdatePostsEvent extends Equatable {
  const AddDeleteUpdatePostsEvent();
}

class AddPostEvent extends AddDeleteUpdatePostsEvent {
  final Posts posts;

  const AddPostEvent({required this.posts});

  @override
  List<Object> get props => [posts];
}

class UpdatePostEvent extends AddDeleteUpdatePostsEvent {
  final Posts posts;

  const UpdatePostEvent({required this.posts});

  @override
  List<Object> get props => [posts];
}

class DeletePostEvent extends AddDeleteUpdatePostsEvent {
  final int postId;

  const DeletePostEvent({required this.postId});

  @override
  List<Object> get props => [postId];
}