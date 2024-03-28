class DatabaseFailure{
  final String message;

  const DatabaseFailure({required this.message});

  @override
  String toString() => 'DatabaseFailure: $message';
}

class DatabaseException implements Exception {
  final String message;

  DatabaseException({required this.message});

  @override
  String toString() => 'DatabaseException: $message';
}



