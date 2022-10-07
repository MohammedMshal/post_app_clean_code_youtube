import 'package:dartz/dartz.dart';
import 'package:posts_app/core/error/failures.dart';
import 'package:posts_app/features/posts/domain/entities/posts.dart';
import 'package:posts_app/features/posts/domain/use_cases/add_post_use_case.dart';
import 'package:posts_app/features/posts/domain/use_cases/update_post_use_case.dart';

import '../use_cases/delete_post_use_case.dart';

abstract class BasePostsRepository{
  Future<Either<Failures,List<Posts>>> getAllPosts();
  Future<Either<Failures,Unit>> deletePost(DeletePostParameters parameters);
  Future<Either<Failures,Unit>> addPost(AddPostParameters parameters);
  Future<Either<Failures,Unit>> updatePost(UpdatePostParameters parameters);
}