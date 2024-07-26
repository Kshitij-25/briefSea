class PostNewNotificationParams {
  final Map<String, dynamic> requestBody;
  final bool isNewRegister;

  PostNewNotificationParams({
    required this.requestBody,
    this.isNewRegister = false,
  });
}
