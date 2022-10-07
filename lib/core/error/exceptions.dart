class ServerException implements Exception{
  final String message;
  ServerException({required this.message});
}

class EmptyCacheException implements Exception{
  final String message;
  EmptyCacheException({required this.message});
}

class NoInternetException implements Exception{
  final String message;
  NoInternetException({required this.message});
}