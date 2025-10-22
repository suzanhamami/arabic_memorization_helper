// ignore_for_file: public_member_api_docs, sort_constructors_first
//TODO: add network connection exception
abstract class BaseException implements Exception {
  final String message;
  BaseException({required this.message});
}

class NetworkException extends BaseException{
  NetworkException({required super.message});
}

class ServerException extends BaseException {
  ServerException({required super.message});
}

class TranscriptNotReadyException extends BaseException {
  TranscriptNotReadyException({required super.message});
}

class TranscribingFailedException extends BaseException {
  TranscribingFailedException({required super.message});
}

class InvalidLanguageException extends BaseException {
  InvalidLanguageException({required super.message});
}
