class AppError {
  final int? statusCode;
  String? errorMessage;

  AppError({this.statusCode, this.errorMessage}) {
    setErrorMessage(statusCode);
  }

  void setErrorMessage(int? code) {
    switch (code) {
      case 400:
        errorMessage = "Oops! Something went wrong. Please try again.";
        break;
      case 401:
        errorMessage = "Whoops! You need to log in to access this.";
        break;
      case 403:
        errorMessage = "Sorry, you don't have permission to do that.";
        break;
      case 404:
        errorMessage = "Uh-oh! We can't find what you're looking for.";
        break;
      case 500:
        errorMessage = "Yikes! Something broke on our end. Please try later.";
        break;
      case 502:
        errorMessage = "Hmmm... We got a bad response from the server.";
        break;
      case 503:
        errorMessage = "Sorry! Our service is currently unavailable. Check back soon.";
        break;
      case 504:
        errorMessage = "Oops! The server took too long to respond. Try again later.";
        break;
      default:
        errorMessage = "An unexpected error occurred. Please try again.";
        break;
    }
  }
}
