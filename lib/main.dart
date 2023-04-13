import 'dart:async';
import 'package:birds_learning_network/src/config/routing/route.dart';
import 'package:birds_learning_network/src/features/core/auth/model/request_model/auto_login_model.dart';
import 'package:birds_learning_network/src/features/core/auth/view/sign_in.dart';
import 'package:birds_learning_network/src/features/core/auth/view_model/login_provider/login_provider.dart';
import 'package:birds_learning_network/src/features/core/auth/view_model/oauth_provider.dart';
import 'package:birds_learning_network/src/features/core/auth/view_model/otp_provider.dart';
import 'package:birds_learning_network/src/features/core/auth/view_model/password_reset/reset_password_provider.dart';
import 'package:birds_learning_network/src/features/core/auth/view_model/sign_up_provider/sign_up.dart';
import 'package:birds_learning_network/src/features/core/settings/view_model/filter_provider.dart';
import 'package:birds_learning_network/src/features/core/walk_through/view/walk_through_one.dart';
import 'package:birds_learning_network/src/features/modules/home/view_model/course_content_provider.dart';
import 'package:birds_learning_network/src/features/modules/home/view_model/home_provider.dart';
import 'package:birds_learning_network/src/features/modules/payment/view_model/payment_provider.dart';
import 'package:birds_learning_network/src/features/modules/profile/view_model/card_provider.dart';
import 'package:birds_learning_network/src/features/modules/profile/view_model/change_password_provider.dart';
import 'package:birds_learning_network/src/features/modules/profile/view_model/edit_preference.dart';
import 'package:birds_learning_network/src/features/modules/profile/view_model/profile_provider.dart';
import 'package:birds_learning_network/src/features/modules/user_cart/view_model/cart_provider.dart';
import 'package:birds_learning_network/src/global_model/services/native_app/device_details.dart';
import 'package:birds_learning_network/src/global_model/services/storage/shared_preferences/user_details.dart';
import 'package:birds_learning_network/src/utils/global_constants/asset_paths/image_path.dart';
import 'package:birds_learning_network/src/utils/global_constants/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:provider/provider.dart';

import 'src/features/modules/courses/view_model/course_provider.dart';
import 'src/global_model/services/storage/shared_preferences/device_info.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Stripe.publishableKey =
  //     "pk_test_51HfG9pIGQmtOoD4q1cQeOak8a9IRG6xwA1Jpr8ecacrMV8QfiqVNO2aArqWCwy0FEB7Pp3cwJ8RJuucMXJBz9I2B003JWbrs36";

  await dotenv.load(fileName: "assets/.env");
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

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback(
      (_) async {
        await getDeviceDetails(context);
        if (!mounted) return;
        String key = await Provider.of<PaymentProvider>(context, listen: false)
            .getStripeKeys(context);
        Stripe.publishableKey = key;
      },
    );
    Timer(const Duration(seconds: 3), () async {
      bool isLoggedIn = await UserPreferences.getLoginStatus();
      if (!mounted) return;
      if (isLoggedIn) {
        try {
          Provider.of<LoginProvider>(context, listen: false)
              .autoLogin(await getData(), context);
        } catch (e) {
          RoutingService.pushReplacementRouting(context, const LoginScreen());
        }
      } else {
        RoutingService.pushReplacementRouting(
            context, const FirstWalkThroughPage());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(
          horizontal: size.width * 0.25, vertical: size.height * 0.25),
      child: Center(
        child: Image.asset(
          ImagePath.birds,
          width: size.width * 0.5,
          height: size.height * 0.5,
        ),
      ),
    );
  }

  Future<AutomaticLoginModel> getData() async {
    return AutomaticLoginModel(deviceId: await DevicePreference.getDeviceId());
  }
}
