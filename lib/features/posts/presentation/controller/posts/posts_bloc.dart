import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_app/core/base_use_case/base_use_cases.dart';

import '../../../../../core/error/failures.dart';
import '../../../domain/entities/posts.dart';
import '../../../domain/use_cases/get_all_posts_use_case.dart';

part 'posts_event.dart';

part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final GetAllPostsUseCase getAllPostsUseCase;

  PostsBloc({
    required this.getAllPostsUseCase,
  }) : super(PostsInitial()) {
    on<PostsEvent>((event, emit) async {
      if (event is GetAllPostsEvent) {
        emit(LoadingPostsState());
        final posts = await getAllPostsUseCase(const NoParameter());
        emit(_mapStates(posts));
      } else if (event is RefreshPostsEvent) {
        final failureOrPosts = await getAllPostsUseCase(const NoParameter());
        emit(_mapStates(failureOrPosts));
      }
    });
  }

  PostsState _mapStates(Either<Failures, List<Posts>> either) {
    return either.fold((l) => ErrorPostsState(message: l.message), (r) =>
        LoadedPostsState(posts: r));
  }

}