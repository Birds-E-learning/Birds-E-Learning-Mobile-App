import 'package:birds_learning_network/src/config/routing/route.dart';
import 'package:birds_learning_network/src/features/core/auth/model/request_model/auth_model.dart';
import 'package:birds_learning_network/src/features/core/auth/view_model/oauth_provider.dart';
import 'package:birds_learning_network/src/features/core/settings/view/filter/filter_screen.dart';
import 'package:birds_learning_network/src/utils/global_constants/colors/colors.dart';
import 'package:birds_learning_network/src/utils/helper_widgets/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_user_agentx/flutter_user_agent.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebView extends StatefulWidget {
  const WebView({
    super.key,
    required this.data,
    required this.url,
    required this.serviceProvider,
  });
  final AuthModel data;
  final String url;
  final String serviceProvider;

  @override
  State<WebView> createState() => _WebViewState();
}

class _WebViewState extends State<WebView> {
  String? url;
  String? userAgent;
  String userAgentt =
      "Mozilla/5.0 (Linux; Android 6.0; Pixel 2 Build/OPD3.170816.012) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/93.0.4577.82 Mobile Safari/537.36";
  String iPhone1 =
      "Mozilla/5.0 (iPhone; CPU iPhone OS 13_1_2 like Mac OS X) AppleWebKit/605.1.15";
  String iPhone2 =
      " (KHTML, like Gecko) Version/13.0.1 Mobile/15E148 Safari/604.1";

  String android1 = "Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) ";
  String android2 =
      "AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.94 Mobile Safari/537.36";
  WebViewController controller = WebViewController();

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      await getUserAgent();
    });
    super.initState();
  }

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
                      auth.webviewCompleted
                          ? RoutingService.pushAndRemoveAllRoute(
                              context, const FilterScreen())
                          : Navigator.pop(context);
                      return NavigationDecision.prevent;
                    } else {
                      return NavigationDecision.navigate;
                    }
                  },
                ))
                // ..setUserAgent(
                //     Platform.isIOS ? "$iPhone1$iPhone2" : "$android1$android2")
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

  Future getUserAgent() async {
    await FlutterUserAgent.init();
    setState(() {
      userAgent = FlutterUserAgent.webViewUserAgent;
    });
  }
}
