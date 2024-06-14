class ApiConstants {
  ApiConstants._();

  static const BASE_URL = 'https://briefsea-backend.onrender.com/forum'; //Test Url
  // static const BASE_URL = 'https://www.api.briefsea.com/forum'; //Prod Url
  static const loginUrl = '$BASE_URL/discussion/login/one';
  static const registerUrl = '$BASE_URL/discussion/register/new';
  static const getUserProfile = '$BASE_URL/discussion/profile/single';
  static const verifyProfile = "$BASE_URL/discussion/profile/new";
  static const editProfile = "$BASE_URL/discussion/profile/single";
  static const uploadAvatar = "$BASE_URL/discussion/uploads/profile/put/avatar";
  static const uploadBanner = "$BASE_URL/discussion/uploads/profile/put/banner";
  static const getAllBriefs = "$BASE_URL/discussion/threads/pagination";
  static const getUserBriefs = "$BASE_URL/discussion/threads";
  static const postBrief = "$BASE_URL/discussion/threads/new";
  static const likeUrl = "$BASE_URL/discussion/threads/likes/new";
  static const getALike = "$BASE_URL/discussion/threads/likes/single";
  static const removelike = "$BASE_URL/discussion/threads/likes/single";
  static const postReply = "$BASE_URL/discussion/threads/comments/new";
  static const getAllComments = "$BASE_URL/discussion/threads/comments/all";
  static const getCommentsLike = "$BASE_URL/discussion/threads/likes/reply";
  static const getImage = "https://briefsea-backend.onrender.com/upload/get";
  static const uploadThreadImage = "https://briefsea-backend.onrender.com/discussion/uploads/threads/put";
  static const getChatUsersList = "$BASE_URL/discussion/chats/single";
  static const createNewChat = "$BASE_URL/discussion/chats/new";
  static const getChatMessages = "$BASE_URL/discussion/chat/messages/single";
  static const sendChatMessage = "$BASE_URL/discussion/chat/messages/new";
  static const getAllReplyOnComment = "$BASE_URL/discussion/threads/comments/reply";
  static const postNewNotification = "$BASE_URL/discussion/notifs/new";
  static const getAllNotification = "$BASE_URL/discussion/notifs/all";
  static const deleteNotification = "$BASE_URL/discussion/notifs/remove";
  static const deleteAllNotification = "$BASE_URL/discussion/notifs/remove/all";
  static const deleteMessageNotification = "$BASE_URL/discussion/notifs/remove/msg";
}
