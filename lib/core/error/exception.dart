class ServerException implements Exception {}

class CacheException implements Exception {}

class ApiException implements Exception {
  final String message;

  ApiException({required this.message});
}

class ValidationException implements Exception {
  final String message;

  ValidationException({required this.message});
}
