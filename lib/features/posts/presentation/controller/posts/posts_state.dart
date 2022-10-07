part of 'posts_bloc.dart';

abstract class PostsState extends Equatable {
  const PostsState();
}

class PostsInitial extends PostsState {
  @override
  List<Object> get props => [];
}

class LoadingPostsState extends PostsState {
  @override
  List<Object> get props => [];
}

class LoadedPostsState extends PostsState {
  final List<Posts> posts ;

  const LoadedPostsState({required this.posts});
  @override
  List<Object> get props => [posts];
}

class ErrorPostsState extends PostsState {
  final String message;

  const ErrorPostsState({required this.message});
  @override
  List<Object> get props => [message];
}
