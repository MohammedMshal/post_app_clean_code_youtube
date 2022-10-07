import 'package:equatable/equatable.dart';

class Failures extends Equatable {
  final String message;

  const Failures({required this.message});

  @override
  List<Object> get props => [message];
}

class ServerFailure extends Failures{
  const ServerFailure({required super.message});
}

class EmptyCacheFailure extends Failures{
  const EmptyCacheFailure({required super.message});
}

class NoInternetFailure extends Failures{
  const NoInternetFailure({required super.message});
}


