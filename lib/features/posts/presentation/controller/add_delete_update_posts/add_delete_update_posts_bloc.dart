import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_app/features/posts/domain/entities/posts.dart';

import '../../../../../core/error/failures.dart';
import '../../../domain/use_cases/add_post_use_case.dart';
import '../../../domain/use_cases/delete_post_use_case.dart';
import '../../../domain/use_cases/update_post_use_case.dart';

part 'add_delete_update_posts_event.dart';

part 'add_delete_update_posts_state.dart';

class AddDeleteUpdatePostsBloc
    extends Bloc<AddDeleteUpdatePostsEvent, AddDeleteUpdatePostsStates> {
  final AddPostUseCase addPostUseCase;
  final UpdatePostUseCase updatePostUseCase;
  final DeletePostUseCase deletePostUseCase;

  AddDeleteUpdatePostsBloc({
    required this.addPostUseCase,
    required this.updatePostUseCase,
    required this.deletePostUseCase,
  }) : super(AddDeleteUpdatePostsInitial()) {
    on<AddDeleteUpdatePostsEvent>((event, emit) async {
      if (event is AddPostEvent) {
        emit(LoadingAddDeleteUpdatePostState());
        final Either<Failures, Unit> addPost =
            await addPostUseCase(AddPostParameters(posts: event.posts));
        emit(_mapStates(either: addPost, message: 'Post Added Successfully'));
      } else if (event is UpdatePostEvent) {
        emit(LoadingAddDeleteUpdatePostState());
        final Either<Failures, Unit> updatePost =
            await updatePostUseCase(UpdatePostParameters(posts: event.posts));
        emit(_mapStates(either: updatePost, message: 'Updated Successfully'));
      } else if (event is DeletePostEvent) {
        emit(LoadingAddDeleteUpdatePostState());
        final Either<Failures, Unit> deletePost =
            await deletePostUseCase(DeletePostParameters(id: event.postId));
        emit(_mapStates(either: deletePost, message: 'Delete Successfully'));
      }
    });
  }
  AddDeleteUpdatePostsStates _mapStates({required Either<Failures, Unit> either,required String message}){
return either.fold((l) => ErrorAddDeleteUpdatePostState(message: l.message), (_) => MessageSuccessAddDeleteUpdatePost(message: message));
  }
}
