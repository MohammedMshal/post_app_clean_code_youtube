import 'package:dartz/dartz.dart';
import 'package:posts_app/core/base_use_case/base_use_cases.dart';
import 'package:posts_app/core/error/failures.dart';
import 'package:posts_app/features/posts/domain/entities/posts.dart';
import 'package:posts_app/features/posts/domain/repository/posts_repository.dart';

class GetAllPostsUseCase extends BaseUseCases<List<Posts>,NoParameter>{
  final BasePostsRepository basePostsRepository;

  GetAllPostsUseCase({required this.basePostsRepository});

  @override
  Future<Either<Failures, List<Posts>>> call(NoParameter parameter) async{
    return await basePostsRepository.getAllPosts();
  }
}