class BaseUrl {
  static const String base = "https://birds-e-learning.herokuapp.com/";

  // USER CORE ENDPOINTS
  final String signUp = "${base}user/basic/signup";
  final String login = "${base}user/basic/login";
  final String verifyOtp = "${base}user/verification/otp";
  final String resendOtp = "${base}user/verification/send/otp?emailAddress=";
  final String oAuthUrl = "${base}user/oauth2/consent";
  final String oAuthValidation = "${base}user/oauth2/consent-validation";
  final String resetOtp = "${base}user/credentials/reset/mail?email=";
  final String validateResetOtp =
      "${base}user/credentials/reset/verification/otp";
  final String resetPassword = "${base}user/credentials/new/submit";
  final String autoLogin = "${base}user/basic/remember/login";

  // filter preferences
  final String getPref = "${base}course/preference/all";
  final String savePref = "${base}course/preference/save-update";

  // User Profile
  final String changePassword = "${base}user/profile/password/update";
  final String logout = "${base}user/logout";
  final String updateProfile = "${base}user/profile/update";
  final String singleUserDetail = "${base}user/single/details?email=";

  // Payment
  final String addCardLink = "${base}payment/card/link";
  final String getDebitCards = "${base}payment/card/all";
  final String deleteCardLink = "${base}payment/card/unlink?cardNo=";
}
