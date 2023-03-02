import 'dart:async';
import 'package:birds_learning_network/src/features/core/auth/view/sign_in.dart';
import 'package:birds_learning_network/src/features/core/auth/view_model/login_provider/login_provider.dart';
import 'package:birds_learning_network/src/features/core/auth/view_model/otp_provider.dart';
import 'package:birds_learning_network/src/features/core/auth/view_model/sign_up_provider/sign_up.dart';
import 'package:birds_learning_network/src/features/core/walk_through/view/walk_through_one.dart';
import 'package:birds_learning_network/src/global_model/services/native_app/device_details.dart';
import 'package:birds_learning_network/src/global_model/services/storage/shared_preferences/user_details.dart';
import 'package:birds_learning_network/src/utils/global_constants/asset_paths/image_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
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
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: Colors.white,
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

    Timer(const Duration(seconds: 3), () async {
      await getDeviceDetails();
      bool isLoggedIn = await UserPreferences.getLoginStatus();
      if (!mounted) return;
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (_) => isLoggedIn
              ? const LoginScreen(firstTime: false)
              : const FirstWalkThroughPage()));
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
}
