import 'package:dartz/dartz.dart';
import 'package:posts_app/core/error/exceptions.dart';
import 'package:posts_app/core/error/failures.dart';
import 'package:posts_app/features/posts/data/data_sources/post_locale_data_source.dart';
import 'package:posts_app/features/posts/data/data_sources/post_remote_data_source.dart';
import 'package:posts_app/features/posts/data/model/posts_model.dart';
import 'package:posts_app/features/posts/domain/entities/posts.dart';
import 'package:posts_app/features/posts/domain/repository/posts_repository.dart';
import 'package:posts_app/features/posts/domain/use_cases/add_post_use_case.dart';
import 'package:posts_app/features/posts/domain/use_cases/delete_post_use_case.dart';
import 'package:posts_app/features/posts/domain/use_cases/update_post_use_case.dart';

import '../../../../core/network/network_info.dart';

class PostsRepository implements BasePostsRepository {
  final BasePostRemoteDataSource basePostRemoteDataSource;
  final BasePostLocaleDataSource basePostLocaleDataSource;
  final BaseNetworkInfo networkInfo;

  PostsRepository({
    required this.basePostRemoteDataSource,
    required this.basePostLocaleDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failures, List<Posts>>> getAllPosts() async {
    if (await networkInfo.isConnected) {
      try {
        final result = await basePostRemoteDataSource.getAllPosts();
        basePostLocaleDataSource.saveCachedPosts(
          SaveCachedPostsParameters(
            postModel: result,
          ),
        );
        return Right(result);
      } on ServerException {
        return const Left(ServerFailure(message: 'test Failure exception'));
      }
    } else {
      try {
        final resultLocalPost = await basePostLocaleDataSource.getCachedPosts();
        return Right(resultLocalPost);
      } on EmptyCacheException {
        return const Left(EmptyCacheFailure(message: 'empty cache error!!!!'));
      }
    }
  }

  @override
  Future<Either<Failures, Unit>> addPost(AddPostParameters parameters) async {
    final PostsModel postsModel = PostsModel(
      title: parameters.posts.title,
      body: parameters.posts.body,
    );
    if (await networkInfo.isConnected) {
      try {
        await basePostRemoteDataSource
            .addPosts(AddPostParameters(posts: postsModel));
        return const Right(unit);
      } on ServerException {
        return const Left(ServerFailure(message: 'Server failure add posts'));
      }
    } else {
      return const Left(
          NoInternetFailure(message: 'No Internet failure add posts'));
    }
  }

  @override
  Future<Either<Failures, Unit>> deletePost(
      DeletePostParameters parameters) async {
    if (await networkInfo.isConnected) {
      try {
        await basePostRemoteDataSource
            .deletePosts(DeletePostParameters(id: parameters.id));
        return const Right(unit);
      } on ServerFailure {
        return const Left(ServerFailure(message: 'Server Failure Delete Post'));
      }
    } else {
      return const Left(
          NoInternetFailure(message: 'No Internet Failure Delete Post'));
    }
  }

  @override
  Future<Either<Failures, Unit>> updatePost(
      UpdatePostParameters parameters) async {
    final PostsModel postsModel = PostsModel(
      title: parameters.posts.title,
      body: parameters.posts.body,
      id: parameters.posts.id,
    );

    if (await networkInfo.isConnected) {
      try {
        await basePostRemoteDataSource
            .updatePosts(UpdatePostParameters(posts: postsModel));
        return const Right(unit);
      } on ServerException {
        return const Left(ServerFailure(message: 'Server Failure Update Post'));
      }
    } else {
      return const Left(
          NoInternetFailure(message: 'No Internet Failure Update Post'));
    }
  }
/*Future<Either<Failures,Unit>> _get({required String message,required Future<Unit>Function() awaitFunc })async{
    if(await networkInfo.isConnected){
      try{
        await awaitFunc();
        return const Right(unit);
      }on ServerFailure{
        return const Left(ServerFailure(message: 'Server Failure Delete Post'));
      }
    }else{
      return const Left(NoInternetFailure(message: 'No Internet Failure Delete Post'));
    }*/
}
