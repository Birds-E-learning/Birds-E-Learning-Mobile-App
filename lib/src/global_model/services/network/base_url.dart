class BaseUrl {
  static const String base = "https://birds-e-learning.herokuapp.com/";

  final String signUp = "${base}user/basic/signup";

  final String login = "${base}user/basic/login";

  final String verifyOtp = "${base}user/verification/otp";

  final String resendOtp = "${base}user/verification/send/otp?emailAddress=";
}
