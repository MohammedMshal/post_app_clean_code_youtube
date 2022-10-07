import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:posts_app/core/error/failures.dart';

abstract class BaseUseCases<T, Parameter> {
  Future<Either<Failures,T>> call(Parameter parameter);
}

class NoParameter extends Equatable {

  const NoParameter();

  @override
  List<Object> get props => [];
}