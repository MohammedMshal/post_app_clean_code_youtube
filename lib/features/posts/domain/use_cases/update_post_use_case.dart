import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:posts_app/core/base_use_case/base_use_cases.dart';
import 'package:posts_app/core/error/failures.dart';
import 'package:posts_app/features/posts/domain/entities/posts.dart';
import 'package:posts_app/features/posts/domain/repository/posts_repository.dart';

class UpdatePostUseCase extends BaseUseCases<Unit,UpdatePostParameters>{
  final BasePostsRepository basePostsRepository;

  UpdatePostUseCase({required this.basePostsRepository});

  @override
  Future<Either<Failures, Unit>> call(UpdatePostParameters parameter) async{
    return await basePostsRepository.updatePost(parameter);
  }


}

class UpdatePostParameters extends Equatable {
  final Posts posts;

  const UpdatePostParameters({required this.posts});

  @override
  List<Object> get props => [posts];
}