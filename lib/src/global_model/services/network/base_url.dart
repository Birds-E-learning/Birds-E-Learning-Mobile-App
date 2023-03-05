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
}
