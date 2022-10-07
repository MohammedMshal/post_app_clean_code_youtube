import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:posts_app/core/base_use_case/base_use_cases.dart';
import 'package:posts_app/core/error/failures.dart';
import 'package:posts_app/features/posts/domain/entities/posts.dart';
import 'package:posts_app/features/posts/domain/repository/posts_repository.dart';

class AddPostUseCase extends BaseUseCases<Unit, AddPostParameters> {
  final BasePostsRepository basePostsRepository;

  AddPostUseCase({required this.basePostsRepository});
  @override
  Future<Either<Failures, Unit>> call(AddPostParameters parameter) async{
   return await basePostsRepository.addPost(parameter);
  }
}

class AddPostParameters extends Equatable {
  final Posts posts;

  const AddPostParameters({required this.posts});

  @override
  List<Object> get props => [posts];
}