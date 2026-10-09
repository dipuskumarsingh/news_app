

class ApiException implements Exception {
  String title;
  String exceptionMassage;
  ApiException({required this.title, required this.exceptionMassage});

  String toErrorMassage(){
    return "$title: $exceptionMassage";
  }
}

class FetchDataException extends ApiException{
  FetchDataException({required String errorMsg}) : super(title:"Network Error:",exceptionMassage: errorMsg );
}

class BadRequestException extends ApiException{
  BadRequestException({required String errorMsg}) : super(title: "Network Error:",exceptionMassage: errorMsg);
}

class UnauthorisedException extends ApiException{
  UnauthorisedException({required String errorMsg}) : super(title: "Network Error:", exceptionMassage: errorMsg);
}

class InvalidInputException extends ApiException{
  InvalidInputException({required String errorMsg}) : super(title: "Network Error:",exceptionMassage: errorMsg);
}