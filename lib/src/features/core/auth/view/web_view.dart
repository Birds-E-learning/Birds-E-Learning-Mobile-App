import 'package:birds_learning_network/src/config/routing/route.dart';
import 'package:birds_learning_network/src/features/core/auth/model/request_model/auth_model.dart';
import 'package:birds_learning_network/src/features/core/auth/view_model/oauth_provider.dart';
import 'package:birds_learning_network/src/features/core/settings/view/filter/filter_screen.dart';
import 'package:birds_learning_network/src/features/modules/home/view/home.dart';
import 'package:birds_learning_network/src/features/modules/home/view_model/home_provider.dart';
import 'package:birds_learning_network/src/utils/global_constants/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebView extends StatefulWidget {
  const WebView(
      {super.key,
      required this.data,
      required this.url,
      required this.serviceProvider,
      required this.validationType});
  final AuthModel data;
  final String url;
  final String serviceProvider;
  final String validationType;

  @override
  State<WebView> createState() => _WebViewState();
}

class _WebViewState extends State<WebView> {
  String? url;
  String userAgentt =
      "Mozilla/5.0 (Linux; Android 6.0; Pixel 2 Build/OPD3.170816.012) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/93.0.4577.82 Mobile Safari/537.36";

  WebViewController controller = WebViewController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer<OAuthProvider>(
          builder: (_, auth, __) => WebViewWidget(
              controller: controller
                ..setJavaScriptMode(JavaScriptMode.unrestricted)
                ..setBackgroundColor(white)
                ..setNavigationDelegate(NavigationDelegate(
                  onNavigationRequest: (request) async {
                    if (request.url.contains("code=") &&
                        request.url.contains("state=")) {
                      await auth.consentValidationRespponse(
                          request.url, context);
                      if (!mounted) return NavigationDecision.prevent;
                      if (auth.webviewCompleted &&
                          widget.validationType == "LOGIN") {
                        Provider.of<HomeProvider>(context, listen: false)
                            .getHomeData(context);
                        RoutingService.pushAndRemoveAllRoute(
                            context, const BirdsHome());
                      } else if (auth.webviewCompleted) {
                        Provider.of<HomeProvider>(context, listen: false)
                            .getHomeData(context);
                        RoutingService.pushAndRemoveAllRoute(
                            context, const FilterScreen());
                      } else {
                        Navigator.pop(context);
                      }
                      return NavigationDecision.prevent;
                    } else {
                      return NavigationDecision.navigate;
                    }
                  },
                ))
                ..setUserAgent(userAgentt)
                ..loadRequest(Uri.parse(widget.url))),
        ),
      ),
    );
  }

  void getResponseData(String response) {
    url = response;
    setState(() {});
  }
}
