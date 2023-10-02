class BaseUrl {
  static const String base = "https://birds-e-learning-dev-e42eb6d4692a.herokuapp.com/";

  // LOGGER ENDPOINT
  // static const String base = "https://9034-102-89-33-22.ngrok-free.app/";

  // USER CORE ENDPOINTS
  final String signUp = "${base}user/basic/signup";
  final String login = "${base}user/basic/login";
  final String verifyOtp = "${base}user/verification/otp";
  final String resendOtp = "${base}user/verification/send/otp?emailAddress=";
  final String oAuthUrl = "${base}user/oauth2/consent";
  final String oAuthValidation = "${base}user/oauth2/consent-validation";
  final String resetOtp = "${base}user/credentials/reset/mail?email=";
  final String validateResetOtp = "${base}user/credentials/reset/verification/otp";
  final String resetPassword = "${base}user/credentials/new/submit";
  final String anonUserUrl = "${base}user/anonymous/credential";
  final String autoLogin = "${base}user/basic/remember/login";

  // filter preferences
  final String getPref = "${base}course/preference/all";
  final String getPrefUser = "${base}course/preference/get";
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

  // Course Management
  final String getCoursePref = "${base}course/preference/graph";
  final String getCourseQuick = "${base}course/quick/graph";
  final String getCoursetrending = "${base}course/trending/graph";
  final String getCourses = "${base}course/graph/all";
  final String allCourses = "${base}course/compact/graph/all";
  final String availableCourses = "${base}course/all";
  String facilitatorUrl(String id) => "${base}course/facilitator?id=$id";
  final String getMiniCoursePref = "${base}course/mini/preference/graph";
  final String getMiniCourseQuick = "${base}course/mini/quick/graph";
  final String getMiniCoursetrending = "${base}course/mini/trending/graph";
   String getCourseById(String id) => "${base}course/get?courseId=$id";

  // Course Analysis

  final String courseAnalysisUrl = "${base}course-analysis/course-lesson";

  // Course Review

  final String saveReviewUrl = "${base}course/reviews";
  String getReviewUrl(String id) => "${base}course/reviews?courseId=$id";

  // Cart

  final String saveCart = "${base}course/shopping/cart/save-update?courseId=";
  final String deleteCart = "${base}course/shopping/cart/unlink?courseId=";
  final String getAllCart = "${base}course/shopping/cart/all";
  final String getSection = "${base}course/sections?courseId=";

  // Wishlist
  final String saveWishlist =
      "${base}course/shopping/wish-list/save-update?courseId=";
  final String deleteWishlist =
      "${base}course/shopping/wish-list/unlink?courseId=";
  final String getAllWishlist = "${base}course/shopping/wish-list/all";

  // Stripe Payment endpoints

  final String stripePayment = "https://api.stripe.com/v1/payment_intents";
  final String stripeKeys = "${base}payment/stripe/credentials";
  final String stripeCharges = "${base}payment/stripe/card-debit/charge";

  // User Paid Courses

  final String coursePaid = "${base}course/user/payment/all";


  // Social Content

   String newsCategoryUrl({String limit = "34"}) => "${base}social-content/news/categories?limit=$limit";
   String  newsByCategoryUrl(String categoryId) => "${base}social-content/news/categories/single?categoryId=$categoryId";
   String newsUrl(String categoryId, {String limit = "30"}) => "${base}social-content/news?categoryId=$categoryId&limit=$limit";

   // Subscription Plans

   final String subscriptionPlanUrl = "${base}subscription/durations";
   final String subscriptionPaymentUrl = "${base}subscription/subscribe";
   final String subscriptionLatestUrl = "${base}subscription/latest";
}
