import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:posts_app/core/base_use_case/base_use_cases.dart';
import 'package:posts_app/core/error/failures.dart';

import '../repository/posts_repository.dart';

class DeletePostUseCase extends BaseUseCases<Unit,DeletePostParameters>{
  final BasePostsRepository basePostsRepository;

  DeletePostUseCase({required this.basePostsRepository});

  @override
  Future<Either<Failures, Unit>> call(DeletePostParameters parameter) async{
    return await basePostsRepository.deletePost(parameter);
  }
}

class DeletePostParameters extends Equatable {
  final int id;

  const DeletePostParameters({required this.id});

  @override
  List<Object> get props => [id];
}