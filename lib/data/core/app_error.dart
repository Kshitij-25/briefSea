class AppError {
  final int? statusCode;
  String? errorMessage;

  AppError({this.statusCode, this.errorMessage}) {
    setErrorMessage(statusCode);
  }

  void setErrorMessage(int? code) {
    switch (code) {
      case 400:
        errorMessage = "Bad Request";
        break;
      case 401:
        errorMessage = "Unauthorized";
        break;
      case 403:
        errorMessage = "Forbidden";
        break;
      case 404:
        errorMessage = "Not Found";
        break;
      case 500:
        errorMessage = "Internal Server Error";
        break;
      case 502:
        errorMessage = "Bad Gateway";
        break;
      case 503:
        errorMessage = "Service Unavailable";
        break;
      case 504:
        errorMessage = "Gateway Timeout";
        break;
      default:
        errorMessage = "An unknown error occurred";
        break;
    }
  }
}
