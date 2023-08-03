import 'package:birds_learning_network/src/features/core/auth/view_model/login_provider/login_provider.dart';
import 'package:birds_learning_network/src/features/core/auth/view_model/oauth_provider.dart';
import 'package:birds_learning_network/src/features/core/auth/view_model/otp_provider.dart';
import 'package:birds_learning_network/src/features/core/auth/view_model/password_reset/reset_password_provider.dart';
import 'package:birds_learning_network/src/features/core/auth/view_model/sign_up_provider/sign_up.dart';
import 'package:birds_learning_network/src/features/core/settings/view_model/filter_provider.dart';
import 'package:birds_learning_network/src/features/core/splash/view/splash_screen.dart';
import 'package:birds_learning_network/src/features/modules/courses/view_model/paid_courses_provider.dart';
import 'package:birds_learning_network/src/features/modules/home/view_model/course_content_provider.dart';
import 'package:birds_learning_network/src/features/modules/home/view_model/facilitator_provider.dart';
import 'package:birds_learning_network/src/features/modules/home/view_model/home_provider.dart';
import 'package:birds_learning_network/src/features/modules/home/view_model/preference_provider.dart';
import 'package:birds_learning_network/src/features/modules/payment/view_model/payment_provider.dart';
import 'package:birds_learning_network/src/features/modules/profile/view_model/card_provider.dart';
import 'package:birds_learning_network/src/features/modules/profile/view_model/change_password_provider.dart';
import 'package:birds_learning_network/src/features/modules/profile/view_model/edit_preference.dart';
import 'package:birds_learning_network/src/features/modules/profile/view_model/profile_provider.dart';
import 'package:birds_learning_network/src/features/modules/user_cart/view_model/cart_provider.dart';
import 'package:birds_learning_network/src/features/unregistered_user_flow/course/view_model/course_content_provider.dart';
import 'package:birds_learning_network/src/features/unregistered_user_flow/course/view_model/course_provider.dart';
import 'package:birds_learning_network/src/features/unregistered_user_flow/home/view_model/home_provider.dart';
import 'package:birds_learning_network/src/utils/global_constants/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:provider/provider.dart';

import 'src/features/modules/courses/view_model/course_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.merchantIdentifier = 'merchant.flutter.stripe.test';
  Stripe.urlScheme = 'flutterstripe';

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  // await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => LoginProvider()),
        ChangeNotifierProvider(create: (context) => SignUpProvider()),
        ChangeNotifierProvider(create: (context) => OtpProvider()),
        ChangeNotifierProvider(create: (context) => OAuthProvider()),
        ChangeNotifierProvider(create: (context) => ResetPasswordProvider()),
        ChangeNotifierProvider(create: (context) => FilterProvider()),
        ChangeNotifierProvider(create: (context) => ProfileProvider()),
        ChangeNotifierProvider(create: (context) => ChangePasswordProvider()),
        ChangeNotifierProvider(create: (context) => CardProvider()),
        ChangeNotifierProvider(create: (context) => HomeProvider()),
        ChangeNotifierProvider(create: (context) => CourseContentProvider()),
        ChangeNotifierProvider(create: (context) => PreferenceProvider()),
        ChangeNotifierProvider(create: (context) => CartProvider()),
        ChangeNotifierProvider(create: (context) => PaymentProvider()),
        ChangeNotifierProvider(create: (context) => CourseProvider()),
        ChangeNotifierProvider(create: (context) => FacilitatorProvider()),
        ChangeNotifierProvider(create: (context) => PaidCoursesProvider()),
        ChangeNotifierProvider(create: (context) => HomePreferenceProvider()),
        ChangeNotifierProvider(create: (context) => UnregisteredHomeProvider()),
        ChangeNotifierProvider(create: (context) => UnregisteredCourseContentProvider()),
        ChangeNotifierProvider(create: (context) => UnregisteredCourseProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: white,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}

