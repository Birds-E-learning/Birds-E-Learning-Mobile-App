import 'dart:async';

import 'package:birds_learning_network/src/config/routing/route.dart';
import 'package:birds_learning_network/src/features/core/auth/model/request_model/auto_login_model.dart';
import 'package:birds_learning_network/src/features/core/auth/view/login/sign_in.dart';
import 'package:birds_learning_network/src/features/core/auth/view_model/login_provider/login_provider.dart';
import 'package:birds_learning_network/src/features/core/walk_through/view/walk_through_one.dart';
import 'package:birds_learning_network/src/features/modules/payment/view_model/payment_provider.dart';
import 'package:birds_learning_network/src/features/unregistered_user_flow/home/view_model/home_provider.dart';
import 'package:birds_learning_network/src/global_model/services/native_app/device_details.dart';
import 'package:birds_learning_network/src/global_model/services/storage/shared_preferences/device_info.dart';
import 'package:birds_learning_network/src/global_model/services/storage/shared_preferences/user_details.dart';
import 'package:birds_learning_network/src/utils/global_constants/asset_paths/image_path.dart';
import 'package:birds_learning_network/src/utils/global_constants/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) async {
        try{
          await getDeviceDetails(context);
          if (!mounted) return;
          String key = await Provider.of<PaymentProvider>(context, listen: false)
              .getStripeKeys(context);
          Stripe.publishableKey = key;
        }catch(e){
          Stripe.publishableKey = "";
        }
      },
    );
    Timer(const Duration(milliseconds: 1500), () async {
      bool isLoggedIn = await UserPreferences.getLoginStatus();
      if (!mounted) return;
      if (isLoggedIn) {
        try {
          Provider.of<LoginProvider>(context, listen: false).autoLogin(await getData(), context);
        } catch (e) {
          RoutingService.pushReplacementRouting(context, const LoginScreen());
        }
      } else {
        await context.read<UnregisteredHomeProvider>().getAnonymousToken(context);
        if(!mounted) return;
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
      padding: EdgeInsets.only(
          left: size.width * 0.20, right: size.width * 0.20, top: size.height * 0.25),
      child: Center(
        child: Column(
          children: [
            SvgPicture.asset(
              ImagePath.birds,
              width: size.width * 0.5,
              height: size.height * 0.5,
            ),
            const SizedBox(height: 30),
            const CircularProgressIndicator(color: black200,)
          ],
        ),
      ),
    );
  }

  Future<AutomaticLoginModel> getData() async {
    return AutomaticLoginModel(deviceId: await DevicePreference.getDeviceId());
  }
}
