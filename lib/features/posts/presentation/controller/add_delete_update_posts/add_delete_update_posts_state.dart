part of 'add_delete_update_posts_bloc.dart';

abstract class AddDeleteUpdatePostsStates extends Equatable {}

class AddDeleteUpdatePostsInitial extends AddDeleteUpdatePostsStates {
  @override
  List<Object> get props => [];
}

class LoadingAddDeleteUpdatePostState extends AddDeleteUpdatePostsStates {
  @override
  List<Object> get props => [];
}

class LoadedAddDeleteUpdatePostState extends AddDeleteUpdatePostsStates {
  @override
  List<Object> get props => [];
}

class ErrorAddDeleteUpdatePostState extends AddDeleteUpdatePostsStates {
  final String message;

   ErrorAddDeleteUpdatePostState({required this.message});

  @override
  List<Object> get props => [message];
}

class MessageSuccessAddDeleteUpdatePost extends AddDeleteUpdatePostsStates {
  final String message;

   MessageSuccessAddDeleteUpdatePost({required this.message});

  @override
  List<Object> get props => [message];
}
