class AppUrls {
  static const baseUrl = "https://ssemw.org/quizzit/wp-json/earn/v1";

  static const loginUrl = "$baseUrl/user/login";
  static const registerUrl = "$baseUrl/user/register";
  static const forgotPassWordUrl = "$baseUrl/forget-password";
  static const resetPasswordUrl = "$baseUrl/reset-password";
  static const verifyOtpUrl = "$baseUrl/user/otp";

  static const getArticle = "$baseUrl/posts";
  static const updateUserCoin = "$baseUrl/user/coin/update";
  static const getUsersCoin = "$baseUrl/user/coin/";

  static const leaderBoard = "$baseUrl/user/leaderboard";
  static const paymentUpdate = "$baseUrl/user/payment/details/save";
  static const profileUpdate = "$baseUrl/user/profile/update";

  static const getTransactionData = "$baseUrl/user/transaction/history";
  static const commonApiUrl = "$baseUrl/common";

  static const readArticleUpdateTime = "$baseUrl/user/post/read/coin/add";
  static const articleReadComplete = "$baseUrl/user/post/read";
  static const playQuizComplete = "$baseUrl/user/quiz/complate";
  static const completedQuizAndArticle = "$baseUrl/user/read/history";
}
