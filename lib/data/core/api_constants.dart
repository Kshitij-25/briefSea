import 'package:flutter/foundation.dart' show immutable, kDebugMode;

@immutable
class ApiConstants {
  const ApiConstants._();

  // Social Media Links
  static const instaUrl = 'https://www.instagram.com/brief.sea/';
  static const linkedInUrl = 'https://www.linkedin.com/company/briefsea/';

  // Terms and Policy Links
  static const termsOfUse = 'https://www.briefsea.com/terms';
  static const privacyPolicy = 'https://www.briefsea.com/privacy-policy';

  // Base URLs
  // static const BASE_URL = 'https://briefsea-backend.onrender.com'; //Test Url
  // static const BASE_URL = 'https://www.api.briefsea.com'; //Prod Url

  static const String BASE_URL = kDebugMode
      ? 'https://briefsea-backend.onrender.com' // Test URL
      : 'https://www.api.briefsea.com'; // Prod URL

  // User authentication
  static const loginUrl = '$BASE_URL/forum/discussion/login/one';
  static const googleAuth = '$BASE_URL/auth/google/callback';
  static const isUserRegistered = '$BASE_URL/forum/verify/email/check';
  static const registerUrl = '$BASE_URL/forum/discussion/register/new';
  static const forgetPassword = "$BASE_URL/forum/discussion/forget/password";
  static const updateFcmToken = "$BASE_URL/forum/discussion/login/update/token";

  // Contacts
  static const uploadContacts = "$BASE_URL/forum/discussion/contacts/add";

  // User profile
  static const getUserProfile = '$BASE_URL/forum/discussion/profile/single';
  static const getOtherProfile = '$BASE_URL/forum/discussion/profile/single';
  static const verifyProfile = '$BASE_URL/forum/discussion/profile/new';
  static const editProfile = '$BASE_URL/forum/discussion/profile/single';
  static const uploadAvatar = '$BASE_URL/forum/discussion/uploads/profile/put/avatar';
  static const uploadBanner = '$BASE_URL/forum/discussion/uploads/profile/put/banner';
  static const deleteAccount = "$BASE_URL/forum/discussion/login/remove";
  static const checkUsername = "$BASE_URL/forum/discussion/profile/check?username=";
  static const getUserAvatar = "$BASE_URL/forum/discussion/profile/avatar";

  // Threads and briefs
  // static const getAllBriefs = '$BASE_URL/forum/discussion/threads/pagination/limit?count=';
  static const getAllBriefs = '$BASE_URL/forum/discussion/threads/pagination/page?number=';
  // static const getAllBriefs = '$BASE_URL/forum/discussion/threads/pagination/';
  static const getUserBriefs = '$BASE_URL/forum/discussion/threads';
  static const getSingleBrief = '$BASE_URL/forum/discussion/threads/single/user';
  static const postBrief = '$BASE_URL/forum/discussion/threads/new';
  static const deleteBrief = '$BASE_URL/forum/discussion/threads/single';
  static const editBrief = '$BASE_URL/forum/discussion/threads/single';

  // Likes
  static const likeUrl = '$BASE_URL/forum/discussion/threads/likes/new';
  static const getALike = '$BASE_URL/forum/discussion/threads/likes/single';
  static const removeLike = '$BASE_URL/forum/discussion/threads/likes/single';

  // Comments
  static const postReply = '$BASE_URL/forum/discussion/threads/comments/new';
  static const getAllComments = '$BASE_URL/forum/discussion/threads/comments/all';
  static const getCommentsLike = '$BASE_URL/forum/discussion/threads/likes/reply';
  static const getAllReplyOnComment = '$BASE_URL/forum/discussion/threads/comments/reply';
  static const deleteComment = '$BASE_URL/forum/discussion/threads/comments/single';
  static const editComment = '$BASE_URL/forum/discussion/threads/comments/single/edit';

  // Uploads
  static const getImage = '$BASE_URL/upload/get';
  static const uploadThreadImage = '$BASE_URL/discussion/uploads/threads/put';

  // Chats
  static const getChatUsersList = '$BASE_URL/forum/discussion/chats/single';
  static const createNewChat = '$BASE_URL/forum/discussion/chats/new';
  static const getChatMessages = '$BASE_URL/forum/discussion/chat/messages/single';
  static const editMessage = '$BASE_URL/forum/discussion/chat/messages/single';
  static const deleteMessage = '$BASE_URL/forum/discussion/chat/messages/single';
  static const sendChatMessage = '$BASE_URL/forum/discussion/chat/messages/new';
  static const getDMUser = '$BASE_URL/forum/discussion/chats/particular';

  // Notifications
  static const sendPushNotification = "https://fcm.googleapis.com/v1/projects/briefsea/messages:send";
  static const postNewNotification = '$BASE_URL/forum/discussion/notifs/new';
  static const briefLikeNotification = '$BASE_URL/forum/discussion/notifs/new/like';
  static const commentLikeNotification = '$BASE_URL/forum/discussion/notifs/new/comment/like';
  static const commentNotification = '$BASE_URL/forum/discussion/notifs/new/comment';
  static const replyNotification = '$BASE_URL/forum/discussion/notifs/new/comment/reply';
  static const getAllNotification = '$BASE_URL/forum/discussion/notifs/all';
  static const notificationViewStatus = '$BASE_URL/forum/discussion/notifs/view';
  static const notificationTapStatus = '$BASE_URL/forum/discussion/notifs/one';
  static const deleteNotification = '$BASE_URL/forum/discussion/notifs/remove';
  static const deleteAllNotification = '$BASE_URL/forum/discussion/notifs/remove/all';
  static const deleteMessageNotification = '$BASE_URL/forum/discussion/notifs/remove/msg';

  // Share Brief
  static const shareBrief = 'https://www.briefsea.com/forum/discussion/thread/share';
}
