class CustomException {
  final int? statusCode;
  final String message;
  CustomException(this.message, this.statusCode);
}

class FetchDataException extends CustomException {
  FetchDataException(super.message, super.statusCode);
}

class BadRequestException extends CustomException {
  BadRequestException(super.message, super.statusCode);
}

class UnauthorisedException extends CustomException {
  UnauthorisedException(super.message, super.statusCode);
}

class InvalidInputException extends CustomException {
  InvalidInputException(super.message, super.statusCode);
}
