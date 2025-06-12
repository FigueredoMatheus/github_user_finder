class AppException implements Exception {
  final String message;
  AppException(this.message);

  @override
  String toString() => message;
}

class NotFoundException extends AppException {
  NotFoundException() : super('Usuário não encontrado.');
}

class ServerException extends AppException {
  ServerException([String message = 'Erro no servidor.']) : super(message);
}

class NetworkException extends AppException {
  NetworkException() : super('Falha na conexão. Verifique sua internet.');
}

class UnexpectedException extends AppException {
  UnexpectedException() : super('Ocorreu um erro inesperado.');
}
