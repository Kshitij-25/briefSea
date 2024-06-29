class ApiConstants {
  ApiConstants._();

  // Social Media Links
  static const instaUrl = 'https://www.instagram.com/brief.sea/';
  static const linkedInUrl = 'https://www.linkedin.com/company/briefsea/';

  // Base URLs
  static const BASE_URL = 'https://briefsea-backend.onrender.com'; //Test Url
  // static const BASE_URL = 'https://www.api.briefsea.com'; //Prod Url

  // User authentication
  static const loginUrl = '$BASE_URL/forum/discussion/login/one';
  static const registerUrl = '$BASE_URL/forum/discussion/register/new';
  static const forgetPassword = "$BASE_URL/forum/discussion/forget/password";

  // User profile
  static const getUserProfile = '$BASE_URL/forum/discussion/profile/single';
  static const getOtherProfile = '$BASE_URL/forum/discussion/profile/single';
  static const verifyProfile = '$BASE_URL/forum/discussion/profile/new';
  static const editProfile = '$BASE_URL/forum/discussion/profile/single';
  static const uploadAvatar = '$BASE_URL/forum/discussion/uploads/profile/put/avatar';
  static const uploadBanner = '$BASE_URL/forum/discussion/uploads/profile/put/banner';
  static const deleteAccount = "$BASE_URL/forum/discussion/login/remove";

  // Threads and briefs
  static const getAllBriefs = '$BASE_URL/forum/discussion/threads/pagination';
  static const getUserBriefs = '$BASE_URL/forum/discussion/threads';
  static const getSingleBrief = '$BASE_URL/forum/discussion/threads/single';
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

  // Uploads
  static const getImage = '$BASE_URL/upload/get';
  static const uploadThreadImage = '$BASE_URL/discussion/uploads/threads/put';

  // Chats
  static const getChatUsersList = '$BASE_URL/forum/discussion/chats/single';
  static const createNewChat = '$BASE_URL/forum/discussion/chats/new';
  static const getChatMessages = '$BASE_URL/forum/discussion/chat/messages/single';
  static const sendChatMessage = '$BASE_URL/forum/discussion/chat/messages/new';
  static const getDMUser = '$BASE_URL/forum/discussion/chats/particular';

  // Notifications
  static const postNewNotification = '$BASE_URL/forum/discussion/notifs/new';
  static const getAllNotification = '$BASE_URL/forum/discussion/notifs/all';
  static const deleteNotification = '$BASE_URL/forum/discussion/notifs/remove';
  static const deleteAllNotification = '$BASE_URL/forum/discussion/notifs/remove/all';
  static const deleteMessageNotification = '$BASE_URL/forum/discussion/notifs/remove/msg';

  // Share Brief
  static const shareBrief = '$BASE_URL/forum/discussion/thread/share';
}
